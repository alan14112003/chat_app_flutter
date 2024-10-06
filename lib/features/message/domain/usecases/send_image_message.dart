import 'dart:io';

import 'package:chat_app_flutter/core/common/domain/usecases/upload_file.dart';
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

class SendFileMessageParams {
  final String chatId;
  final File content;
  final int? replyId;

  SendFileMessageParams({
    required this.chatId,
    required this.content,
    this.replyId,
  });
}

class SendImageMessage
    implements UseCase<List<Message>, SendFileMessageParams> {
  final MessageRepository _messageRepository;
  final UploadFile _uploadFile;

  SendImageMessage({
    required MessageRepository messageRepository,
    required UploadFile uploadFile,
  })  : _messageRepository = messageRepository,
        _uploadFile = uploadFile;

  @override
  Future<Either<Failure, List<Message>>> call(
    SendFileMessageParams params,
  ) async {
    try {
      // upload ảnh lên cloud
      final response = await _uploadFile.call(
        UploadFileParams(
          file: params.content,
        ),
      );

      if (response.isLeft()) {
        return Left(
          response.getLeft().getOrElse(() => Failure()),
        );
      }

      final imageUrl = response.getRight().getOrElse(() => '');

      final message = await _messageRepository.sendMessage(
        params.chatId,
        SendMessageBody(
          type: MessageTypeEnum.IMAGE,
          image: imageUrl,
          replyId: params.replyId,
        ),
      );

      // cập nhật messages
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
