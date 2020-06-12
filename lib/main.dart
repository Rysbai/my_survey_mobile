import 'package:flutter/material.dart';
import 'package:neobissurvey/screens/home.dart';
import 'package:neobissurvey/theme/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neobis Survey',
      theme: defaultTheme,
      home: HomeScreen(),
    );
  }
}

// 0188d1
