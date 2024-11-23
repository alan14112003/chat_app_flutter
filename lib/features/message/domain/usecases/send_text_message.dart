import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/constants/message_type_enum.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/message/data/sources/send_message_body.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class SendTextMessageParam {
  final String chatId;
  final String content;
  final int? replyId;
  final bool isChatBotContent;

  SendTextMessageParam({
    required this.chatId,
    required this.content,
    this.replyId,
    required this.isChatBotContent,
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
      final message = await _messageRepository.sendMessage(
        params.chatId,
        SendMessageBody(
          type: MessageTypeEnum.TEXT,
          text: params.content,
          replyId: params.replyId,
          isChatBotContent: params.isChatBotContent,
        ),
      );

      //  cập nhật messages
      final messages = await HandleMessageUtil.addFetchedMessageToLocal(
        message,
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
