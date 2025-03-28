import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/video_call/domain/repositories/video_call_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class JoinVideoCallParams {
  final String chatId;

  JoinVideoCallParams({
    required this.chatId,
  });
}

class JoinVideoCall implements UseCase<int, JoinVideoCallParams> {
  final VideoCallRepository _videoCallRepository;

  JoinVideoCall({
    required VideoCallRepository videoCallRepository,
  }) : _videoCallRepository = videoCallRepository;

  @override
  Future<Either<Failure, int>> call(JoinVideoCallParams params) async {
    try {
      final videoCallState = await _videoCallRepository.joinVideoCall(
        params.chatId,
      );

      return right(videoCallState);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
