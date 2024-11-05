import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/auth/data/sources/active_email_body.dart';
import 'package:chat_app_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class ActiveEmailParams {
  final String code;
  final String email;

  ActiveEmailParams({
    required this.code,
    required this.email,
  });
}

class ActiveEmailUsecase implements UseCase<void, ActiveEmailParams> {
  final AuthRepository _authRepository;

  ActiveEmailUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(ActiveEmailParams params) async {
    try {
      await _authRepository.activeEmail(ActiveEmailBody(
        code: params.code,
        email: params.email,
      ));
      return Right(null);
    } on DioException catch (e) {
      // Xử lý lỗi từ Dio (lỗi kết nối, lỗi API)
      return HandleErrorDio.call(e);
    } catch (e) {
      // Xử lý các lỗi khác
      return Left(Failure(e.toString()));
    }
  }
}
