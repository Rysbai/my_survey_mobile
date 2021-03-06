import 'package:graphql/client.dart';
import 'package:neobissurvey/api/base.dart';
import 'package:neobissurvey/entities/survey.dart';
import 'package:neobissurvey/factories/survey.dart';

class SurveyApi {
  static Future<Survey> getSurveyByCode(String code) async {
    final String query = r'''
      query GetSurveyByCode($code: String!)  { 
        surveyByCode(code: $code) {
          id,
          title,
          description,
          isAnonymous,
          isPublic,
          questions {
            id,
            payload,
            allowMultipleAnswer,
            options {
              id,
              payload
            }
          }
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
        documentNode: gql(query), variables: <String, String>{"code": code});

    final QueryResult response = await client.query(options);
    if (response.hasException) {
      throw Exception('WTF');
    }
    return SurveyEntityFactory.fromMap(response.data["surveyByCode"]);
  }

  static Future<List<Survey>> getPublicSurveys() async {
    final String query = r'''
      query {
        surveys {
          id,
          title,
          description,
          isAnonymous,
          isOpen,
          questions {
            id,
            payload,
            allowMultipleAnswer,
            options {
              id,
              payload
            }
          }
        }
      }
    ''';
    final QueryOptions options = QueryOptions(documentNode: gql(query));
    final QueryResult response = await client.query(options);
    if (response.hasException) {
      print(response.exception);
      throw Exception('WTF');
    }
    List<Survey> surveys =
        SurveyEntityFactory.surveysFromMapsList(response.data['surveys']);
    return SurveyEntityFactory.surveysFromMapsList(response.data['surveys']);
  }
}

class AnswerAPi {
  static Future<String> saveQuestionAnswer(
      String questionId, List<String> optionIds) async {
    final String query = r'''
      mutation SaveUserAnswer ($questionId: ID!, $options: [ID]) {
        saveUserAnswer (questionId: $questionId, options: $options) {
          message
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
        documentNode: gql(query),
        variables: <String, dynamic>{
          "questionId": questionId,
          "options": optionIds
        });
    final response = await client.query(options);
    if (response.hasException) {
      throw Exception('WTF');
    }

    return 'ok';
  }
}
