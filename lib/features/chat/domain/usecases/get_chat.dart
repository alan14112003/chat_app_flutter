import 'package:chat_app_flutter/core/common/models/chat.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/chat/domain/repositories/chat_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class GetChatParams {
  final String chatId;

  GetChatParams({
    required this.chatId,
  });
}

class GetChat implements UseCase<Chat, GetChatParams> {
  final ChatRepository _chatRepository;

  GetChat({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  @override
  Future<Either<Failure, Chat>> call(GetChatParams params) async {
    try {
      final chat = await _chatRepository.getChat(params.chatId);
      return right(chat);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
