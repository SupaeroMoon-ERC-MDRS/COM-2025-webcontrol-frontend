import 'package:supaeromoon_webcontrol/data/localization.dart';
import 'package:supaeromoon_webcontrol/net/message_id.dart';
import 'package:supaeromoon_webcontrol/net/net.dart';
import 'package:supaeromoon_webcontrol/ui/screen.dart';

abstract class LifeCycle{
  static void preInit(){
    Loc.setLanguage("en_EN");

    if(!Net.init()){ // TODO some retry mechanism
      return;
    }

    Net.requestControl().then((final MessageId res){
      AppState.hasServer = res == MessageId.OK || res == MessageId.DENIED;
      AppState.hasControl = res == MessageId.OK;
      AppState.notifier.update();
    });
  }

  static void postInit(){

  }
}