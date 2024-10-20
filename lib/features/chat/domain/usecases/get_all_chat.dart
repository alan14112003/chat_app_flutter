import 'package:chat_app_flutter/core/common/models/chat.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/chat/domain/repositories/chat_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class GetAllChat implements UseCase<List<Chat>, NoParams> {
  final ChatRepository _chatRepository;

  GetAllChat({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  @override
  Future<Either<Failure, List<Chat>>> call(NoParams params) async {
    try {
      final chats = await _chatRepository.getAllChats();
      return right(chats);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
