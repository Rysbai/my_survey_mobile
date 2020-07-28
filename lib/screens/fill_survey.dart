import 'package:flutter/material.dart';
import 'package:neobissurvey/entities/survey.dart';
import 'package:neobissurvey/widgets/question_card.dart';
import 'package:neobissurvey/widgets/survey_card.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FillSurveyScreen extends StatefulWidget {
  final Survey survey;
  FillSurveyScreen({Key key, this.survey}) : super(key: key);

  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<FillSurveyScreen> {
  List<String> answeredQuestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.survey.title),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          ListView(children: [
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
                  getAnsweredQuestionsPercent() == 1.0
                      ? ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            onPressed: () => {Navigator.pop(context)},
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Finish',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
          ]),
          Positioned(
            height: 5.0,
            width: MediaQuery.of(context).size.width + 20.0,
            left: -10.0,
            top: 0.0,
            child: LinearPercentIndicator(
              lineHeight: 5.0,
              percent: getAnsweredQuestionsPercent(),
              backgroundColor: Colors.transparent,
              progressColor: Colors.green,
              linearStrokeCap: LinearStrokeCap.butt,
            ),
          ),
        ],
      ),
    );
  }

  List<QuestionCard> renderQuestions() {
    List<QuestionCard> questions = <QuestionCard>[];
    widget.survey.questions.forEach((question) {
      questions.add(QuestionCard(
        question: question,
        setAnswered: setAnswered,
      ));
    });
    return questions;
  }

  double getAnsweredQuestionsPercent() {
    int all = widget.survey.questions.length;
    return answeredQuestions.length / all;
  }

  void setAnswered(String questionId) {
    if (!answeredQuestions.contains(questionId)) {
      setState(() {
        answeredQuestions.add(questionId);
      });
    }
  }
}
