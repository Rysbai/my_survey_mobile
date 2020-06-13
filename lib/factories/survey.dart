import 'dart:convert';

import 'package:neobissurvey/entities/survey.dart';

class SurveyEntityFactory {
  static Survey fromJson(String jsonString) {
    final jsonData = json.decode(jsonString);
    return SurveyEntityFactory.fromMap(jsonData);
  }

  static Survey fromMap(Map<String, dynamic> map) {
    return SurveyEntityFactory.create(
        id: map["id"],
        title: map["title"],
        description: map["description"],
        isAnonymous: map["isAnonymous"],
        questions:
            QuestionEntityFactory.questionsFromMapsList(map["questions"]));
  }

  static Survey create(
      {String id,
      String title,
      String description,
      bool isAnonymous,
      List<Question> questions}) {
    return Survey(
        id: id,
        title: title,
        description: description,
        isAnonymous: isAnonymous,
        questions: questions);
  }
}

class QuestionEntityFactory {
  static List<Question> questionsFromMapsList(List<Map<String, dynamic>> data) {
    List<Question> questions = <Question>[];

    data.forEach((element) {
      questions.add(QuestionEntityFactory.fromMap(element));
    });
    return questions;
  }

  static Question fromJson(String jsonString) {
    final questionMap = json.decode(jsonString);
    return QuestionEntityFactory.fromJson(questionMap);
  }

  static Question fromMap(Map<String, dynamic> map) {
    return QuestionEntityFactory.create(
        id: map["id"],
        payload: map["payload"],
        allowMultipleAnswer: map["allowMultipleAnswer"],
        options: OptionEntityFactory.optionsFromMapsList(map["options"]));
  }

  static Question create(
      {String id,
      String payload,
      bool allowMultipleAnswer,
      List<Option> options}) {
    return Question(
        id: id,
        payload: payload,
        allowMultipleAnswer: allowMultipleAnswer,
        options: options);
  }
}

class OptionEntityFactory {
  static List<Option> optionsFromMapsList(List<Map<String, dynamic>> map) {
    List<Option> options = <Option>[];

    map.forEach((element) {
      options.add(OptionEntityFactory.fromMap(element));
    });

    return options;
  }

  static Option fromJson(String data) {
    final optionMap = json.decode(data);

    return OptionEntityFactory.fromMap(optionMap);
  }

  static Option fromMap(Map<String, dynamic> map) {
    return OptionEntityFactory.create(
        id: map["id"], questionId: map["questionId"], payload: map["payload"]);
  }

  static Option create({String id, String questionId, String payload}) {
    return Option(id: id, questionId: questionId, payload: payload);
  }
}
