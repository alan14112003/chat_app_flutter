import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class RequestFriends implements UseCase<List<Friend>, NoParams> {
  final FriendRepository _friendRepository;

  RequestFriends({
    required FriendRepository friendRepository,
  }) : _friendRepository = friendRepository;

  @override
  Future<Either<Failure, List<Friend>>> call(NoParams params) async {
    try {
      final friends = await _friendRepository.requestFriends();
      return right(friends);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
