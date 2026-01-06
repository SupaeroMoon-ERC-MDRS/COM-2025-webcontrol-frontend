import 'package:flutter/material.dart';
import 'package:supaeromoon_webcontrol/data/localization.dart';
import 'package:supaeromoon_webcontrol/net/message_id.dart';
import 'package:supaeromoon_webcontrol/net/net.dart';
import 'package:supaeromoon_webcontrol/ui/screen.dart';
import 'package:supaeromoon_webcontrol/ui/theme.dart';

const Map<bool, String> _status = {
  false: "request_control",
  true: "release_control"
};

class BackendControl extends StatefulWidget {
  const BackendControl({super.key});

  @override
  State<BackendControl> createState() => _BackendControlState();
}

class _BackendControlState extends State<BackendControl> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if(AppState.hasControl){
          if(await Net.release()){
            AppState.hasControl = false;
            AppState.notifier.update();
          }
        }
        else{
          Net.requestControl().then((final MessageId res){
            AppState.hasServer = res == MessageId.OK || res == MessageId.DENIED;
            AppState.hasControl = res == MessageId.OK;
            AppState.notifier.update();
          });
        }
      },
      child: Text(Loc.get(_status[AppState.hasControl]!), style: ThemeManager.textStyle,),
    );
  }
}