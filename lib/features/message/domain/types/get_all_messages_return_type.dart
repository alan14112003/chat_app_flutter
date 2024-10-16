import 'package:chat_app_flutter/core/common/models/message.dart';

class GetAllMessagesReturnType {
  final bool isLast;
  final List<Message> messages;

  GetAllMessagesReturnType({this.isLast = false, required this.messages});
}
