import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class DeleteMessageParams {
  final Message message;

  DeleteMessageParams({
    required this.message,
  });
}

class DeleteMessage implements UseCase<bool, DeleteMessageParams> {
  final MessageRepository _messageRepository;

  DeleteMessage({
    required MessageRepository messageRepository,
  }) : _messageRepository = messageRepository;

  @override
  Future<Either<Failure, bool>> call(DeleteMessageParams params) async {
    try {
      bool res = await _messageRepository.deleteMessage(params.message.id!);

      return right(res);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
