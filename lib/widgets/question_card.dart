import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neobissurvey/entities/survey.dart';

import '../main.dart';

class QuestionCard extends StatefulWidget {
  Question question;
  Function setAnswered;
  QuestionCard({Key key, this.question, this.setAnswered}) : super(key: key);
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  List<String> checkedOptions = <String>[];

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
                  widget.question.payload,
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
            onChange: (bool value) {
              onChange(option.id, value);
            },
            checked: checkedOptions.contains(option.id),
            multiple: widget.question.allowMultipleAnswer,
          ))
        });

    return options;
  }

  void onChange(String id, bool checked) {
    widget.setAnswered(widget.question.id);

    if (widget.question.allowMultipleAnswer) {
      if (checked) {
        setState(() {
          checkedOptions = <String>[...checkedOptions, id];
        });
      } else {
        setState(() {
          checkedOptions.remove(id);
          checkedOptions = checkedOptions;
        });
      }
    } else {
      if (checked) {
        setState(() {
          checkedOptions = <String>[id];
        });
      } else {
        setState(() {
          checkedOptions = <String>[];
        });
      }
    }
//    AnswerAPi.saveQuestionAnswer(widget.question.id, checkedOptions);
    socketService.updateQuestionResults(widget.question.id, checkedOptions);
  }
}

class _Option extends StatelessWidget {
  final Option option;
  final Function onChange;
  final bool checked;
  final bool multiple;

  _Option({Key key, this.option, this.onChange, this.checked, this.multiple})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        multiple
            ? Checkbox(
                onChanged: onChange,
                value: checked,
                checkColor: Theme.of(context).primaryColor,
              )
            : Radio(
                value: option.id,
                activeColor: Theme.of(context).primaryColor,
                groupValue: checked ? option.id : null,
                onChanged: (String value) {
                  onChange(true);
                },
              ),
        Container(
            padding: EdgeInsets.all(0.0),
            width: MediaQuery.of(context).size.width * 0.7,
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text(option.payload),
              ],
            ))
      ],
    );
  }

  Widget getRadioButton() {
    return Radio(
      value: option.id,
      groupValue: checked ? option.id : null,
      onChanged: onChange,
    );
  }
}
