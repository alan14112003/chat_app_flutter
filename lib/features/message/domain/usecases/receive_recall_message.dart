import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class ReceiveRecallMessageParam {
  final Message message;

  ReceiveRecallMessageParam({
    required this.message,
  });
}

class ReceiveRecallMessage
    implements UseCase<List<Message>, ReceiveRecallMessageParam> {
  final MessageRepository _messageRepository;

  ReceiveRecallMessage({
    required MessageRepository messageRepository,
  }) : _messageRepository = messageRepository;

  @override
  Future<Either<Failure, List<Message>>> call(
    ReceiveRecallMessageParam params,
  ) async {
    try {
      //  load lại messages
      final messageResult = await _messageRepository.getAllMessages(
        params.message.chatId!,
        null,
      );

      return right(messageResult.messages);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
