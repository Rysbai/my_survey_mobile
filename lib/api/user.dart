import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:neobissurvey/api/base.dart';
import 'package:neobissurvey/constants/shared_presences_keys.dart';
import 'package:neobissurvey/entities/user.dart';
import 'package:neobissurvey/factories/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  static Future<User> auth(User user) async {
    final String query = r'''
      mutation CreateSurvey ($name: String!) { 
        auth(name: $name) 
          { 
            message, 
            token,
            user 
              { id, name}
          }
        }
    ''';

    final QueryOptions queryOptions = QueryOptions(
        documentNode: gql(query),
        variables: <String, dynamic>{"name": user.name});

    final QueryResult result = await client.query(queryOptions);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    final String token = result.data['auth']['token'];
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_TOKEN, token);
    prefs.setString(USER, json.encode(result.data["auth"]["user"]));

    return UserEntityFactory.fromMap(result.data["auth"]["user"]);
  }
}
