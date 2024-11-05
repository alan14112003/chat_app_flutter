import 'package:chat_app_flutter/core/common/models/user_with_friend.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class FindFriendByEmailParams {
  final String email;

  FindFriendByEmailParams({
    required this.email,
  });
}

class FindFriendByEmail
    implements UseCase<UserWithFriend?, FindFriendByEmailParams> {
  final FriendRepository _friendRepository;

  FindFriendByEmail({required FriendRepository friendRepository})
      : _friendRepository = friendRepository;

  @override
  Future<Either<Failure, UserWithFriend?>> call(
      FindFriendByEmailParams params) async {
    try {
      final user = await _friendRepository.findFriendByEmail(params.email);
      return Right(user);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
