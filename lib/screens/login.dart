import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neobissurvey/api/user.dart';
import 'package:neobissurvey/constants/auth_statuses.dart';
import 'package:neobissurvey/entities/user.dart';
import 'package:neobissurvey/factories/user.dart';
import 'package:neobissurvey/screens/home.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key, this.loginSuccessCallback}) : super(key: key);
  final VoidCallback loginSuccessCallback;
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _textInputKey = new GlobalKey<FormState>();
  String authState = AUTH_NOT_DETERMINED;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _textInputKey,
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter your name',
                    labelText: 'Name *'),
                onSaved: (String name) {
                  final User user =
                      UserEntityFactory.create(id: '', name: name);
                  UserApi.auth(user)
                      .then((value) => widget.loginSuccessCallback())
                      .catchError((exception) => {});
                },
              ),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: authState == AUTH_IN_PROGRESS
                  ? null
                  : () {
                      setState(() {
                        authState = AUTH_IN_PROGRESS;
                      });
                      final form = _textInputKey.currentState;
                      if (form.validate()) {
                        form.save();
                      } else {
                        setState(() {
                          authState = AUTH_FAILED;
                        });
                      }
                    },
            )
          ],
        )),
      ),
    );
  }
}
