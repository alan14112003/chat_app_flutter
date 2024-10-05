import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class GetMessageParams {
  final int messageId;

  GetMessageParams({
    required this.messageId,
  });
}

class GetMessage implements UseCase<Message, GetMessageParams> {
  final MessageRepository _messageRepository;

  GetMessage({
    required MessageRepository messageRepository,
  }) : _messageRepository = messageRepository;

  @override
  Future<Either<Failure, Message>> call(GetMessageParams params) async {
    try {
      final message = await _messageRepository.getMessage(params.messageId);
      return right(message);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
