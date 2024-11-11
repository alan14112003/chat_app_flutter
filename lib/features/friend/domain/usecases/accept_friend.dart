import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class AcceptFriendParams {
  final String friendId;

  AcceptFriendParams({
    required this.friendId,
  });
}

class AcceptFriend implements UseCase<void, AcceptFriendParams> {
  final FriendRepository _friendRepository;

  AcceptFriend({
    required FriendRepository friendRepository,
  }) : _friendRepository = friendRepository;

  @override
  Future<Either<Failure, void>> call(AcceptFriendParams params) async {
    try {
      await _friendRepository.acceptFriendById(params.friendId);
      return Right(null);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
