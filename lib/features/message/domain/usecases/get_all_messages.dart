import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllMessages implements UseCase<List<Message>, String> {
  final MessageRepository _messageRepository;

  GetAllMessages({
    required MessageRepository messageRepository,
  }) : _messageRepository = messageRepository;

  @override
  Future<Either<Failure, List<Message>>> call(String chatId) async {
    return _messageRepository.getAllMessages(chatId);
  }
}
