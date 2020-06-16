import 'package:flutter/material.dart';
import 'package:neobissurvey/entities/survey.dart';
import 'package:neobissurvey/widgets/question_card.dart';
import 'package:neobissurvey/widgets/survey_card.dart';

class FillSurveyScreen extends StatefulWidget {
  Survey survey;
  FillSurveyScreen({Key key, this.survey}) : super(key: key);

  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<FillSurveyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.survey.title),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                SurveyCard(
                  survey: widget.survey,
                  justInfo: true,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: renderQuestions(),
                ),
//                ...renderQuestions(),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<QuestionCard> renderQuestions() {
    List<QuestionCard> questions = <QuestionCard>[];
    widget.survey.questions.forEach((question) {
      questions.add(QuestionCard(
        question: question,
      ));
    });
    return questions;
  }
}
