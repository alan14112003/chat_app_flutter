import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:dio/dio.dart';
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

class SendTextMessage implements UseCase<List<Message>, SendTextMessageParam> {
  final MessageRepository _messageRepository;

  SendTextMessage({
    required MessageRepository messageRepository,
  }) : _messageRepository = messageRepository;

  @override
  Future<Either<Failure, List<Message>>> call(
    SendTextMessageParam params,
  ) async {
    try {
      // gửi message đi
      final message = await _messageRepository.sendTextMessages(
        params.chatId,
        content: params.content,
        replyId: params.replyId,
      );

      // lấy về message đầy đủ
      final messageNew = await _messageRepository.getMessage(message.id as int);

      // lấy ra messages trong shared
      final messages = _messageRepository.getLocalMessages(
        messageNew.chatId as String,
      );

      // thêm vào danh sách
      messages.insert(0, messageNew);

      // lưu lại vào shared
      _messageRepository.setLocalMessages(
        messageNew.chatId as String,
        messages,
      );

      return right(messages);
    } on DioException catch (e) {
      print(e);
      return HandleErrorDio.call(e);
    } catch (e) {
      print(e);
      return Left(Failure(e.toString()));
    }
  }
}
