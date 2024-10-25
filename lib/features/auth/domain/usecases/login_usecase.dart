import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/auth/data/sources/auth_body.dart';
import 'package:chat_app_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}

class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthRepository _authRepository;

  LoginUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    try {
      // Gọi repository để thực hiện login
      final user = await _authRepository.login(
        LoginBody(
          email: params.email,
          password: params.password,
        ),
      );

      // Trả về đối tượng User sau khi đăng nhập thành công
      return right(user);
    } on DioException catch (e) {
      // Xử lý lỗi từ Dio (lỗi kết nối, lỗi API)
      return HandleErrorDio.call(e);
    } catch (e) {
      // Xử lý các lỗi khác
      return Left(Failure(e.toString()));
    }
  }
}
