import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class GetAllMessagesParams {
  final String chatId;
  final int? before;

  GetAllMessagesParams({
    required this.chatId,
    this.before,
  });
}

class GetAllMessages implements UseCase<List<Message>, GetAllMessagesParams> {
  final MessageRepository _messageRepository;

  GetAllMessages({
    required MessageRepository messageRepository,
  }) : _messageRepository = messageRepository;

  @override
  Future<Either<Failure, List<Message>>> call(
    GetAllMessagesParams params,
  ) async {
    try {
      final messages = await _messageRepository.getAllMessages(
        params.chatId,
        params.before,
      );
      return right(messages);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
