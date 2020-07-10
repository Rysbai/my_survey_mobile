import 'dart:convert';

import 'package:neobissurvey/constants/shared_presences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket socket;

  void createSocketConnection() {
    socket = IO.io(
        'http://192.168.31.123:5000/update-question-results', <String, dynamic>{
      'transports': ['websocket'],
    });
    this.socket.on("connect", (_) => print('Connected'));
    this.socket.on("disconnect", (_) => print('Disconnected'));
  }

  Future<bool> updateQuestionResults(
      String questionId, List<String> optionIds) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(USER) ?? '';
    final Map<String, dynamic> user = json.decode(userJson);

    final Map<String, dynamic> data = <String, dynamic>{
      "userId": user['id'],
      "questionId": questionId,
      "options": optionIds
    };
    this.socket.emit('update-user-answer', data);

    return true;
  }
}
