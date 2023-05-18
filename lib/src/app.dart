import 'package:caustic/src/activity/desktop_home_activity.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DesktopHomeActivity(),
    );
  }
}
