import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class ReceiveNewMessageParam {
  final Message message;

  ReceiveNewMessageParam({
    required this.message,
  });
}

class ReceiveNewMessage
    implements UseCase<List<Message>, ReceiveNewMessageParam> {
  final MessageRepository _messageRepository;

  ReceiveNewMessage({
    required MessageRepository messageRepository,
  }) : _messageRepository = messageRepository;

  @override
  Future<Either<Failure, List<Message>>> call(
    ReceiveNewMessageParam params,
  ) async {
    try {
      //  cập nhật messages
      final messages = await HandleMessageUtil.addFetchedMessageToLocal(
        params.message,
        _messageRepository,
      );

      return right(messages);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
