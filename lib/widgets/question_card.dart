import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neobissurvey/entities/survey.dart';

class QuestionCard extends StatefulWidget {
  Question question;
  QuestionCard({Key key, this.question}) : super(key: key);
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Question payload',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                )),
            SizedBox(
              height: 8.0,
            ),
            ...renderOptions()
          ],
        ),
      ),
    );
  }

  List<_Option> renderOptions() {
    List<_Option> options = <_Option>[];

    widget.question.options.forEach((option) => {
          options.add(_Option(
            option: option,
          ))
        });

    return options;
  }
}

class _Option extends StatelessWidget {
  Option option;
  _Option({Key key, this.option}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
            onPressed: () {
              print('Clicked option');
            },
            icon: Icon(
              FontAwesomeIcons.circle,
              color: Theme.of(context).primaryColor,
            )),
        Text('Option payload')
      ],
    );
  }
}
