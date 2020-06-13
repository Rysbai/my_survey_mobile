import 'package:flutter/material.dart';
import 'package:neobissurvey/entities/survey.dart';

class SurveyCard extends StatelessWidget {
  Survey survey;
  SurveyCard({Key key, this.survey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[Text('')],
        ),
      ),
    );
  }
}
