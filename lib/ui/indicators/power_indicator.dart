import 'package:flutter/material.dart';
import 'package:supaeromoon_webcontrol/common.dart';
import 'package:supaeromoon_webcontrol/data/telem_data.dart';
import 'package:supaeromoon_webcontrol/ui/screen.dart';
import 'package:supaeromoon_webcontrol/ui/theme.dart';

class PowerIndicator extends StatefulWidget {
  const PowerIndicator({super.key});

  @override
  State<PowerIndicator> createState() => _PowerIndicatorState();
}

class _PowerIndicatorState extends State<PowerIndicator> {

  @override
  void initState() {
    telemetryData.addListener(_update);
    AppState.notifier.addListener(_update);
    super.initState();
  }

  void _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    print("Voltage raw: ${telemetryData.value.voltage} , shown ${representNumber(telemetryData.value.voltage, targetChar: 7)}");
    return AppState.hasServer ? 
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 100, 
            child: Text("${representNumber(telemetryData.value.voltage, targetChar: 7)} V", style: ThemeManager.textStyle, textAlign: TextAlign.right,)
          ),
          SizedBox(
            width: 100, 
            child: Text("${representNumber(telemetryData.value.current, targetChar: 8)} A", style: ThemeManager.textStyle, textAlign: TextAlign.right,)
          )
        ],
      )
      :
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 100, 
            child: Text("-- V", style: ThemeManager.textStyle, textAlign: TextAlign.right,)
          ),
          SizedBox(
            width: 100, 
            child: Text("-- A", style: ThemeManager.textStyle, textAlign: TextAlign.right,)
          )
        ],
      );
  }

  @override
  void dispose() {
    telemetryData.removeListener(_update);
    AppState.notifier.removeListener(_update);
    super.dispose();
  }
}