import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/video_call/domain/repositories/video_call_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class CloseVideoCallParams {
  final String chatId;

  CloseVideoCallParams({
    required this.chatId,
  });
}

class CloseVideoCall implements UseCase<void, CloseVideoCallParams> {
  final VideoCallRepository _videoCallRepository;

  CloseVideoCall({
    required VideoCallRepository videoCallRepository,
  }) : _videoCallRepository = videoCallRepository;

  @override
  Future<Either<Failure, void>> call(CloseVideoCallParams params) async {
    try {
      await _videoCallRepository.closeVideoCall(params.chatId);

      return right(null);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
