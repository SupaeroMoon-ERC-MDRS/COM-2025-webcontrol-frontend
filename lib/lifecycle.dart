import 'dart:io';

import 'package:supaeromoon_webcontrol/data/localization.dart';
import 'package:supaeromoon_webcontrol/net/message_id.dart';
import 'package:supaeromoon_webcontrol/net/net.dart';
import 'package:supaeromoon_webcontrol/ui/screen.dart';

abstract class LifeCycle{
  static Future<void> preInit() async {
    Loc.setLanguage("en_EN");
    if(!Net.init()){
      exit(0);
    }
    final int res = await Net.requestControl();
    AppState.hasControl = res == MessageId.OK.index;
    AppState.hasServer = res == MessageId.OK.index || res == MessageId.DENIED.index;
  }

  static void postInit(){

  }
}