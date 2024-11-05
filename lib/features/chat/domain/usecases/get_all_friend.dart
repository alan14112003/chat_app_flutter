import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/chat/domain/repositories/chat_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class GetAllFriend implements UseCase<List<Friend>, NoParams> {
  final ChatRepository _chatRepository;

  GetAllFriend({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  @override
  Future<Either<Failure, List<Friend>>> call(NoParams params) async {
    try {
      final friends = await _chatRepository.getAllFriends();
      return right(friends);
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      return HandleErrorDio.call(e);
    } catch (e) {
      print('Catch Error: ${e.toString()}');
      return left(Failure(e.toString()));
    }
  }
}
