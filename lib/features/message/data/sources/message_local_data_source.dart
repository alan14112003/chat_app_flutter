import 'dart:convert';

import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageLocalDataSource {
  final SharedPreferences _preferences;

  MessageLocalDataSource({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  Future<bool> setMessages(String chatId, List<Message> messages) {
    return _preferences.setString('messages:$chatId', jsonEncode(messages));
  }

  List<Message> getMessages(String chatId) {
    final messageJson = _preferences.getString('messages:$chatId');
    if (messageJson == null) {
      return List.empty();
    }

    List<dynamic> jsonList = jsonDecode(messageJson);

    return jsonList.map((data) => Message.fromJson(data)).toList();
  }
}
