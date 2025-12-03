import 'dart:typed_data';

import 'package:supaeromoon_webcontrol/data/control_data.dart';
import 'package:supaeromoon_webcontrol/net/message_id.dart';
import 'package:supaeromoon_webcontrol/net/raspi_ip.dart';
import 'package:supaeromoon_webcontrol/ui/screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class Net{
  static bool init(){
    controlData.addListener((){
      if(AppState.hasControl){
        send(controlData.value.toBytes());
      }
    });
    return true;
  }

  static Future<Uint8List> _sendCmd(final Uint8List request) async {
    try{
      final WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(raspiIp));
      channel.sink.add(request);
      return await channel.stream.first;
    }
    catch(ex){
      return Uint8List.fromList([MessageId.CERR.index]);
    }
    
  }

  static Future<bool> ping() async {
    return (await _sendCmd(Uint8List.fromList([MessageId.PING.index])))[0] == MessageId.ECHO.index;
  }

  static Future<bool> send(final Uint8List data) async {
    return (await _sendCmd(Uint8List.fromList([MessageId.PUSH.index, ...data])))[0] == MessageId.OK.index;
  }

  static Future<Uint8List> get() async {
    return await _sendCmd(Uint8List.fromList([MessageId.GET.index]));
  }

  static Future<int> requestControl() async {
    return (await _sendCmd(Uint8List.fromList([MessageId.CTRL.index])))[0];
  }

  static Future<bool> release() async {
    return (await _sendCmd(Uint8List.fromList([MessageId.BYE.index])))[0] == MessageId.OK.index;
  }
}