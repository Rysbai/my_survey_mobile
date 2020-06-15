import 'package:flutter/material.dart';
import 'package:neobissurvey/constants/auth_statuses.dart';
import 'package:neobissurvey/constants/shared_presences_keys.dart';
import 'package:neobissurvey/screens/home.dart';
import 'package:neobissurvey/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootScreen extends StatefulWidget {
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  String authState = AUTH_NOT_DETERMINED;
  @override
  Widget build(BuildContext context) {
    switch (authState) {
      case AUTH_SUCCEEDED:
        return HomeScreen();
        break;

      case AUTH_NOT_DETERMINED:
        return AuthScreen(
          loginSuccessCallback: loginSuccessCallback,
        );
        break;

      default:
        return AuthScreen();
    }
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((pref) {
      final String token = pref.getString(USER_TOKEN) ?? '';

      if (token.length == 0) {
        setState(() {
          authState = AUTH_NOT_DETERMINED;
        });
      } else {
        setState(() {
          authState = AUTH_SUCCEEDED;
        });
      }
    });
  }

  void loginSuccessCallback() {
    setState(() {
      authState = AUTH_SUCCEEDED;
    });
  }
}
