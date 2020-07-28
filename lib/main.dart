import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:neobissurvey/api/socket.dart';
import 'package:neobissurvey/screens/root_screen.dart';
import 'package:neobissurvey/theme/main.dart';

import 'factories/app_initializer.dart';
import 'factories/socket_dependency_injection.dart';

Injector injector;
SocketService socketService;

void main() async {
  DependencyInjection().initialise(Injector.getInjector());
  injector = Injector.getInjector();
  await AppInitializer().initialize(injector);
  socketService = injector.get<SocketService>();
  socketService.createSocketConnection();
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
