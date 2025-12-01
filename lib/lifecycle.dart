import 'dart:io';

import 'package:supaeromoon_webcontrol/data/localization.dart';
import 'package:supaeromoon_webcontrol/net/net.dart';

abstract class LifeCycle{
  static void preInit(){
    Loc.setLanguage("en_EN");
    if(!Net.init()){
      exit(0);
    }
    Net.requestControl();
  }

  static void postInit(){

  }
}