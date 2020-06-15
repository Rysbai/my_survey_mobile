class Survey {
  String id;
  String title;
  String description;
  bool isAnonymous;
  List<Question> questions;

  Survey(
      {this.id,
      this.title,
      this.description,
      this.isAnonymous,
      this.questions});
}

class Question {
  String id;
  String payload;
  bool allowMultipleAnswer;
  List<Option> options;

  Question({this.id, this.payload, this.allowMultipleAnswer, this.options});
}

class Option {
  String id;
  String payload;

  Option({this.id, this.payload});
}
