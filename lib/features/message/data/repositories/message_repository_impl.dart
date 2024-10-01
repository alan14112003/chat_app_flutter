import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/features/message/data/sources/message_remote_data_source.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class MessageRepositoryImpl implements MessageRepository {
  // remote data source
  final MessageRemoteDataSource _messageRemoteDataSource;

  MessageRepositoryImpl({
    required MessageRemoteDataSource messageRemoteDataSource,
  }) : _messageRemoteDataSource = messageRemoteDataSource;

  @override
  Future<Either<Failure, List<Message>>> getAllMessages(String chatId) async {
    try {
      final messages = await _messageRemoteDataSource.getAllMessage(chatId);

      return right(messages);
    } on DioException catch (e) {
      final response = e.response;

      if (response != null) {
        return left(Failure(response.data['message']));
      }

      return left(Failure(e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, Message>> sendTextMessages(
    String chatId, {
    required String content,
    int? replyId,
  }) async {
    try {
      final message = await _messageRemoteDataSource.sendMessage(
        chatId,
        type: 1,
        text: content,
        replyId: replyId,
      );

      return right(message);
    } on DioException catch (e) {
      final response = e.response;

      if (response != null) {
        return left(Failure(response.data['message']));
      }

      return left(Failure(e.message ?? ''));
    }
  }
}
