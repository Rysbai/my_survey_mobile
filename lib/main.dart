import 'package:flutter/material.dart';
import 'package:neobissurvey/screens/root_screen.dart';
import 'package:neobissurvey/theme/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeobisSurvey',
      theme: defaultTheme,
      home: RootScreen(),
    );
  }
}
