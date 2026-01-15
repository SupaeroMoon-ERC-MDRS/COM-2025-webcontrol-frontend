import 'package:flutter/material.dart';
import 'package:supaeromoon_webcontrol/data/localization.dart';
import 'package:supaeromoon_webcontrol/data/notifiers.dart';
import 'package:supaeromoon_webcontrol/net/net.dart';
import 'package:supaeromoon_webcontrol/ui/controls/backend_control.dart';
import 'package:supaeromoon_webcontrol/ui/controls/control_stack.dart';
import 'package:supaeromoon_webcontrol/ui/controls/sliding_switch.dart';
import 'package:supaeromoon_webcontrol/ui/indicators/backend_state_indicator.dart';
import 'package:supaeromoon_webcontrol/ui/indicators/power_indicator.dart';
import 'package:supaeromoon_webcontrol/ui/theme.dart';

abstract class AppState{
  static bool isRotated = true;
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
          PowerIndicator(),
          const Spacer(),
          BackendStateIndicator(),
          BackendControl(),
          IconButton(
            onPressed: (){
              Net.stopBackend();
              AppState.hasControl = false;
              AppState.notifier.update();
            },
            icon: Icon(Icons.stop)
          ),
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
  final SlidingSwitchController<int> _slider = SlidingSwitchController<int>(
    items: [0, 1], // TODO servo calibration but not for MDRS
    names: ["controller_controls", "simplified_controls"], // TODO servo calibration but not for MDRS
    onChanged: (final int i){},
    active: 0,
    notifier: BlankNotifier(null)
  );

  @override
  void initState() {
    _slider.notifier!.addListener(_update);
    super.initState();
  }

  void _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: SlidingSwitch(
            controller: _slider
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder:(context, constraints) {
              return _slider.active == 0 ?
              ControlStack(size: constraints.biggest)
              :
              _slider.active == 1 ?
              SimplifiedControlStack(size: constraints.biggest)
              :
              Container(); // TODO servo calibration but not for MDRS
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _slider.notifier!.removeListener(_update);
    super.dispose();
  }
}