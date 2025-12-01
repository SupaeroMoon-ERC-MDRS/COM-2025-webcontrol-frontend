import 'dart:typed_data';

import 'package:supaeromoon_webcontrol/net/message_id.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class Net{
  static String? _backendAddress;

  static bool init(){
    // TODO findraspi
    return false;
    /*controlData.addListener((){
      send(controlData.value.toBytes());
    });*/

  }

  static Future<Uint8List> _sendCmd(final Uint8List request) async {
    final WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(_backendAddress!));
    channel.sink.add(request);
    return await channel.stream.first;
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

  static Future<bool> requestControl() async {
    return (await _sendCmd(Uint8List.fromList([MessageId.CTRL.index])))[0] == MessageId.OK.index;
  }

  static Future<bool> release() async {
    return (await _sendCmd(Uint8List.fromList([MessageId.BYE.index])))[0] == MessageId.OK.index;
  }
}