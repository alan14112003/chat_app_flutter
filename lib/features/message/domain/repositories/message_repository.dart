import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class MessageRepository {
  Future<Either<Failure, List<Message>>> getAllMessages(String chatId);
}
