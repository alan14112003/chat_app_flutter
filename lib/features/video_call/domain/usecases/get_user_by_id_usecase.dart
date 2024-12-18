import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/video_call/domain/repositories/video_call_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class GetUserByIdUsecaseParams {
  final String userId;

  GetUserByIdUsecaseParams({
    required this.userId,
  });
}

class GetUserByIdUsecase implements UseCase<User, GetUserByIdUsecaseParams> {
  final VideoCallRepository _videoCallRepository;

  GetUserByIdUsecase({
    required VideoCallRepository videoCallRepository,
  }) : _videoCallRepository = videoCallRepository;

  @override
  Future<Either<Failure, User>> call(GetUserByIdUsecaseParams params) async {
    try {
      final user = await _videoCallRepository.getUserById(params.userId);

      return right(user);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
