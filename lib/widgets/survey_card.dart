import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neobissurvey/entities/survey.dart';
import 'package:neobissurvey/screens/fill_survey.dart';

class SurveyCard extends StatefulWidget {
  Survey survey;
  bool justInfo = false;
  SurveyCard({Key key, this.survey, this.justInfo = false}) : super(key: key);

  @override
  _SurveyCardState createState() => _SurveyCardState();
}

class _SurveyCardState extends State<SurveyCard> {
  bool showAllDescription = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      widget.survey.title,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('${widget.survey.questions.length} questions',
                          style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                      Text(widget.survey.isAnonymous ? 'Anonymous' : 'Public',
                          style: TextStyle(color: Colors.green))
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Text(
                      widget.survey.description,
                      style: TextStyle(color: Colors.black54),
                      maxLines: showAllDescription ? null : 2,
                    ),
                  ),
                  Row(
                    children: getActions(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getActions() {
    if (widget.justInfo) {
      return <Widget>[
        FlatButton(
          padding: EdgeInsets.all(0),
          child: Text(
            showAllDescription ? 'Less' : 'More',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            setState(() {
              showAllDescription = !showAllDescription;
            });
          },
        ),
      ];
    } else {
      return <Widget>[
        FlatButton(
          padding: EdgeInsets.all(0),
          child: Text(
            showAllDescription ? 'Less' : 'More',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            setState(() {
              showAllDescription = !showAllDescription;
            });
          },
        ),
        SizedBox(width: 8.0),
        RaisedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => FillSurveyScreen(
                          survey: widget.survey,
                        )));
          },
          color: Theme.of(context).primaryColor,
          child: Text(
            'Fill',
            style: TextStyle(color: Colors.white),
          ),
        )
      ];
    }
  }
}
