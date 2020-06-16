import 'package:flutter/material.dart';
import 'package:neobissurvey/api/survey.dart';
import 'package:neobissurvey/entities/survey.dart';
import 'package:neobissurvey/widgets/survey_card.dart';

class SearchSurveyCard extends StatefulWidget {
  _SearchSurveyCardState createState() => _SearchSurveyCardState();
}

class _SearchSurveyCardState extends State<SearchSurveyCard> {
  final searchFormKey = GlobalKey<FormState>();
  Survey foundSurvey;
  String searchSurveyStatus = SearchSurveyStatus.notDetermined;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 250.0,
                  child: Form(
                    key: searchFormKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Enter survey code to find'),
                      onSaved: (String code) {
                        SurveyApi.getSurveyByCode(code)
                            .then((survey) => {
                                  setState(() {
                                    searchSurveyStatus =
                                        SearchSurveyStatus.success;
                                    foundSurvey = survey;
                                  })
                                })
                            .catchError((error) {
                          setState(() {
                            foundSurvey = null;
                            searchSurveyStatus = SearchSurveyStatus.fail;
                          });
                        });
                      },
                      validator: (String value) {
                        return value.length < 4
                            ? 'Code length should be more then 6'
                            : null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Ink(
                  decoration: ShapeDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: CircleBorder(),
                      shadows: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.2),
                            blurRadius: 6.0)
                      ]),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        searchSurveyStatus = SearchSurveyStatus.inProgress;
                      });

                      final textInput = searchFormKey.currentState;
                      if (textInput.validate()) {
                        textInput.save();
                      } else {
                        setState(() {
                          searchSurveyStatus = SearchSurveyStatus.notDetermined;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            getSearchSurveyContent()
          ],
        ),
      ),
    );
  }

  Widget getSearchSurveyContent() {
    switch (searchSurveyStatus) {
      case SearchSurveyStatus.fail:
        return Text('Survey does not exists!');
        break;

      case SearchSurveyStatus.inProgress:
        return Center(
          child: CircularProgressIndicator(),
        );
        break;

      case SearchSurveyStatus.success:
        return SurveyCard(
          survey: foundSurvey,
        );
        break;

      default:
        return SizedBox();
    }
  }
}

class SearchSurveyStatus {
  static const String notDetermined = "NOT_DETERMINED";
  static const String inProgress = "IN_PROGRESS";
  static const String success = "SUCCESS";
  static const String fail = "FAIL";
}
