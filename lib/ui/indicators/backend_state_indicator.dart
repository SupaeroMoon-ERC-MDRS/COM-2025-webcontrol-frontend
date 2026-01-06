import 'package:flutter/material.dart';
import 'package:supaeromoon_webcontrol/data/localization.dart';
import 'package:supaeromoon_webcontrol/ui/screen.dart';
import 'package:supaeromoon_webcontrol/ui/theme.dart';

const Map<bool, Map<bool, String>> _status = {
  false: {
    true: "backend_unavailable",
    false: "backend_unavailable",
  },
  true: {
    true: "in_control",
    false: "not_in_control"
  }
};

class BackendStateIndicator extends StatefulWidget {
  const BackendStateIndicator({super.key});

  @override
  State<BackendStateIndicator> createState() => _BackendStateIndicatorState();
}

class _BackendStateIndicatorState extends State<BackendStateIndicator> {
  @override
  void initState() {
    AppState.notifier.addListener(_update);
    super.initState();
  }

  void _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ThemeManager.globalStyle.padding),
      child: Text(Loc.get(_status[AppState.hasServer]![AppState.hasControl]!), style: ThemeManager.textStyle,),
    );
  }

  @override
  void dispose() {
    AppState.notifier.removeListener(_update);
    super.dispose();
  }
}