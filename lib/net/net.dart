import 'dart:async';
import 'dart:typed_data';

import 'package:supaeromoon_webcontrol/data/control_data.dart';
import 'package:supaeromoon_webcontrol/net/message_id.dart';
import 'package:supaeromoon_webcontrol/net/raspi_ip.dart';
import 'package:supaeromoon_webcontrol/ui/screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PendingRequest {
  final Completer<Uint8List?> completer = Completer<Uint8List?>();
  final int requestId;
  final MessageId type;

  PendingRequest(this.type):requestId=nextId;

  static int nextId = 0;
  static int get genId => nextId++ & 0xFE;
}

abstract class Net{

  static WebSocketChannel? channel;
  static bool isInitialized = false;
  static final Map<int, PendingRequest> _pendingRequests = {};

  static bool init(){
    try{
      channel = WebSocketChannel.connect(Uri.parse(raspiIp));
    }
    catch(ex){
      channel = null;
      isInitialized = false;
      return false;
    }

    channel!.stream.listen((final dynamic msg){
      if(msg is Uint8List && msg.length >= 2){
        final PendingRequest? req = _pendingRequests.remove(msg[1]);
        if(req == null){ return; }
        req.completer.complete(msg);
      }
    });

    controlData.addListener((){
      if(AppState.hasControl || true){
        send(controlData.value.toBytes());
      }
    });

    isInitialized = true;
    return true;
  }

  static Future<bool> _sendCmd(final Uint8List request, final MessageId id) async {
    try{
      channel?.sink.add(Uint16List.fromList([id.index, 0xFF, ...request]));
      return true;
    }
    catch(ex){
      return false;
    }
  }

  static void handleNoResponse(final MessageId id){
    // TODO
  }

  static Future<Uint8List?> _sendCmdWaitResponse(final MessageId id) async {
    try{
      PendingRequest req = PendingRequest(id);
      _pendingRequests[req.requestId] = req;
      channel?.sink.add(Uint16List.fromList([id.index, req.requestId]));

      try {
        return await req.completer.future.timeout(
          const Duration(seconds: 3), 
          onTimeout: (){
            _pendingRequests.remove(req.requestId);
            handleNoResponse(id);
            return null;
          },
        );
      } 
      catch(ex){
        _pendingRequests.remove(req.requestId); 
        handleNoResponse(id);
        return null;
      }
    }
    catch(ex){
      return Uint8List.fromList([MessageId.CERR.index]);
    }
  }

  static Future<bool> ping() async {
    final Uint8List? bytes = await _sendCmdWaitResponse(MessageId.PING);
    if(bytes == null || bytes.isEmpty){
      return false;
    }
    return MessageId.values[bytes[0]] == MessageId.ECHO;
  }

  static Future<bool> send(final Uint8List data) async {
    return await _sendCmd(data, MessageId.PUSH);
  }

  static Future<bool> get() async {
    final Uint8List? bytes = await _sendCmdWaitResponse(MessageId.GET);
    if(bytes == null || bytes.length < 2){
      return false;
    }

    // TODO process bytes.sublist(2) as telemetry

    return true;
  }

  static Future<MessageId> requestControl() async {
    final Uint8List? bytes = await _sendCmdWaitResponse(MessageId.CTRL);
    if(bytes == null || bytes.isEmpty){
      return MessageId.CERR;
    }
    return MessageId.values[bytes[0]];
  }

  static Future<bool> release() async {
    return await _sendCmd(Uint8List(0), MessageId.BYE);
  }
}