import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neobissurvey/api/survey.dart';
import 'package:neobissurvey/entities/survey.dart';

class QuestionCard extends StatefulWidget {
  Question question;
  QuestionCard({Key key, this.question}) : super(key: key);
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
                  'Question payload',
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
    AnswerAPi.saveQuestionAnswer(widget.question.id, checkedOptions);
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
        Text(option.payload)
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
