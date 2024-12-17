import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/video_call/domain/repositories/video_call_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class RefuseVideoCallParams {
  final String chatId;

  RefuseVideoCallParams({
    required this.chatId,
  });
}

class RefuseVideoCall implements UseCase<void, RefuseVideoCallParams> {
  final VideoCallRepository _videoCallRepository;

  RefuseVideoCall({
    required VideoCallRepository videoCallRepository,
  }) : _videoCallRepository = videoCallRepository;

  @override
  Future<Either<Failure, void>> call(RefuseVideoCallParams params) async {
    try {
      await _videoCallRepository.refuseVideoCall(params.chatId);

      return right(null);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
