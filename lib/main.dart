import 'package:flutter/material.dart';
import 'package:supaeromoon_webcontrol/common.dart';
import 'package:supaeromoon_webcontrol/data/localization.dart';
import 'package:supaeromoon_webcontrol/lifecycle.dart';
import 'package:supaeromoon_webcontrol/ui/screen.dart';
import 'package:supaeromoon_webcontrol/ui/theme.dart';

void main() async {
  await LifeCycle.preInit();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  void initState() {
    ThemeManager.notifier.addListener(_update);
    Loc.notifier.addListener(_update);
    LifeCycle.postInit();
    super.initState();
  }

  void _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return MaterialApp(
      navigatorKey: mainWindowNavigatorKey,
      title: Loc.get("title"),
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getThemeData(context),
      home: Scaffold(
        body: MainScreen()
      ),
    );
  }
}
