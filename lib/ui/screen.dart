import 'package:flutter/material.dart';
import 'package:supaeromoon_webcontrol/data/localization.dart';
import 'package:supaeromoon_webcontrol/data/notifiers.dart';
import 'package:supaeromoon_webcontrol/ui/controls/control_stack.dart';
import 'package:supaeromoon_webcontrol/ui/theme.dart';

abstract class AppState{
  static bool isRotated = false;
  static bool hasServer = false;
  static bool hasControl = false;

  static BlankNotifier notifier = BlankNotifier(null);
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    AppState.notifier.addListener(_update);
    super.initState();
  }

  void _update() => setState(() { });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: AppState.isRotated ? 1 : 0,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: MainAppBar()
          ),
          Expanded(
            child: ControlView()
          )
        ],
      )
    );
  }
}

class MainAppBar extends StatefulWidget {
  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeManager.globalStyle.secondaryColor
      ),
      child: Row(
        children: [
          Container(color: Colors.red,child: Text("PH, Voltage"),),
          Container(color: Colors.red,child: Text("PH, Current"),),
          const Spacer(),
          TextButton(
            onPressed: (){
              int index = Loc.languages.indexOf(Loc.selected) + 1;
              if(index >= Loc.languages.length){ index = 0; }
              Loc.setLanguage(Loc.languages[index]);
            }, 
            child: Text(Loc.selected.substring(Loc.selected.length - 2), 
              style: ThemeManager.subTitleStyle,
            )
          ),
          Container(color: Colors.red,child: Text("PH, Backend active ind/toggle"),),
          IconButton(
            onPressed: (){
              AppState.isRotated = !AppState.isRotated;
              AppState.notifier.update();
            },
            icon: Icon(Icons.screen_rotation_rounded)
          )
          // horizontal/vertical toggle
        ],
      ),
    );
  }
}

class ControlView extends StatefulWidget {
  const ControlView({super.key});

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context, constraints) {
        return ControlStack(size: constraints.biggest, orientation: AppState.isRotated,);
      },
    );
  }
}