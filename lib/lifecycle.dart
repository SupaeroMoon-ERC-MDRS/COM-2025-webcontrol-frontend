import 'package:supaeromoon_webcontrol/data/localization.dart';

abstract class LifeCycle{
  static void preInit(){
    Loc.setLanguage("en_EN");
  }

  static void postInit(){

  }
}