import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neobissurvey/api/survey.dart';
import 'package:neobissurvey/entities/survey.dart';
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
                print('Search icon pressed!');
              },
              icon: Icon(Icons.scanner))
        ],
      ),
      body: ListView(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 270.0,
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
                            searchSurveyStatus =
                                SearchSurveyStatus.notDetermined;
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
              getSearchSurveyContent(),
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
                        snapshot.data.forEach((survey) =>
                            widgets.add(SurveyCard(survey: survey)));
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
