import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/auth/data/sources/register_body.dart';
import 'package:chat_app_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class RegisterParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final int gender;

  RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gender,
  });
}

class RegisterUsecase implements UseCase<void, RegisterParams> {
  final AuthRepository _authRepository;

  RegisterUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(RegisterParams params) async {
    try {
      await _authRepository.register(RegisterBody(
        firstName: params.firstName,
        lastName: params.lastName,
        email: params.email,
        password: params.password,
        gender: params.gender,
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
