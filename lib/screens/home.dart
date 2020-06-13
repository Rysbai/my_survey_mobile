import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Neobis Survey'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  print('Search icon pressed!');
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Form(
                      child: TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.search),
                              hintText: 'Enter survey code'),
                          onSaved: null),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
