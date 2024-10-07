import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class RecallMessageParams {
  final int messageId;

  RecallMessageParams({
    required this.messageId,
  });
}

class RecallMessage implements UseCase<Message, RecallMessageParams> {
  final MessageRepository _messageRepository;

  RecallMessage({
    required MessageRepository messageRepository,
  }) : _messageRepository = messageRepository;

  @override
  Future<Either<Failure, Message>> call(RecallMessageParams params) async {
    try {
      final message = await _messageRepository.recallMessage(
        params.messageId,
      );

      return Right(message);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
