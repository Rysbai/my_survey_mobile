import 'dart:convert';

import 'package:neobissurvey/entities/user.dart';

class UserEntityFactory {
  static User fromJsonString(String jsonString) {
    final data = json.decode(jsonString);

    return UserEntityFactory.fromMap(data);
  }

  static User fromMap(Map<String, dynamic> map) {
    return UserEntityFactory.create(id: map["id"], name: map["name"]);
  }

  static User create({String id, String name}) {
    return User(id: id, name: name);
  }
}
