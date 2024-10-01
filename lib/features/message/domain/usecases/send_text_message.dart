import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:fpdart/fpdart.dart';

class SendTextMessageParam {
  final String chatId;
  final String content;
  final int? replyId;

  SendTextMessageParam({
    required this.chatId,
    required this.content,
    this.replyId,
  });
}

class SendTextMessage implements UseCase<Message, SendTextMessageParam> {
  final MessageRepository _messageRepository;

  SendTextMessage({
    required MessageRepository messageRepository,
  }) : _messageRepository = messageRepository;

  @override
  Future<Either<Failure, Message>> call(SendTextMessageParam params) {
    return _messageRepository.sendTextMessages(
      params.chatId,
      content: params.content,
      replyId: params.replyId,
    );
  }
}
