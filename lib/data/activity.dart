import 'dart:async';

import 'package:supaeromoon_webcontrol/net/net.dart';
import 'package:supaeromoon_webcontrol/ui/screen.dart';

abstract class Activity{

  static Timer? _whileControlling;
  static Timer? _whileIdle;

  static void init(){
    AppState.notifier.addListener(_onControlChange);
  }

  static void _onControlChange(){
    if(AppState.hasControl){
      _whileIdle?.cancel();
      _whileControlling = Timer.periodic(Duration(seconds: 1), (timer) async {
        final bool prev = AppState.hasServer;
        if(!await Net.ping()){
          AppState.hasServer = false;
        }
        else{
          AppState.hasServer = true;
        }
        if(prev != AppState.hasServer){
          AppState.notifier.update();
        }
      });
    }
    else{
      _whileControlling?.cancel();
      _whileIdle = Timer.periodic(Duration(seconds: 1), (timer) async {
        final bool prev = AppState.hasServer;
        if(!await Net.get()){
          AppState.hasServer = false;
        }
        else{
          AppState.hasServer = true;
        }
        if(prev != AppState.hasServer){
          AppState.notifier.update();
        }
      });
    }
  }
}