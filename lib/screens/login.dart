import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neobissurvey/api/user.dart';
import 'package:neobissurvey/constants/auth_statuses.dart';
import 'package:neobissurvey/entities/user.dart';
import 'package:neobissurvey/factories/user.dart';

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
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'NeobisSurvey',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 20.0,
            ),
            Form(
              key: _textInputKey,
              child: TextFormField(
                enabled: authState != AUTH_IN_PROGRESS,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your name to continue',
                  helperText: '*Name will be hidden in anonymous surveys',
                ),
                onSaved: (String name) {
                  final User user =
                      UserEntityFactory.create(id: '', name: name);
                  UserApi.auth(user)
                      .then((value) => widget.loginSuccessCallback())
                      .catchError((exception) => {});
                },
                validator: (String value) {
                  return value.length < 4
                      ? 'Name length should be more then 4'
                      : null;
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
