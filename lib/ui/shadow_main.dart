import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadow/ui/ui.dart';

import '../config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(ShadowMainApp()));
}

class ShadowMainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shadow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.android),
      home: NavigationHomeScreen(),
    );
  }
}
