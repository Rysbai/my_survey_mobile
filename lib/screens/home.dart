import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neobissurvey/api/survey.dart';
import 'package:neobissurvey/entities/survey.dart';
import 'package:neobissurvey/widgets/search_survey.dart';
import 'package:neobissurvey/widgets/survey_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchFormKey = GlobalKey<FormState>();
  Survey foundSurvey;
  String searchSurveyStatus = SearchSurveyStatus.notDetermined;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Neobis Survey',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                print('Quit icon pressed!');
              },
              icon: Icon(FontAwesomeIcons.signOutAlt))
        ],
      ),
      body: ListView(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(child: SearchSurveyCard()),
              SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(3.0, 0, 0, 0),
                child: Text(
                  'Open surveys',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
              Container(
                child: FutureBuilder<List<Survey>>(
                    future: SurveyApi.getPublicSurveys(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error');
                        }

                        List<Widget> widgets = <Widget>[];
                        snapshot.data
                            .forEach((survey) => widgets.add(SurveyCard(
                                  survey: survey,
                                  justInfo: false,
                                )));
                        return Column(children: widgets);
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 30.0), title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.qrcode, size: 30.0),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 15.0,
                backgroundImage: NetworkImage('http://i.imgur.com/zL4Krbz.jpg'),
              ),
              title: SizedBox.shrink())
        ],
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
