import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/features/auth/data/sources/active_email_body.dart';
import 'package:chat_app_flutter/features/auth/data/sources/auth_body.dart';
import 'package:chat_app_flutter/features/auth/data/sources/register_body.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  // Hàm xử lý đăng nhập
  Future<User> login(LoginBody loginBody) async {
    // Chuyển loginBody thành JSON
    final Response<dynamic> response = await _dio.post(
      '/auth/login',
      data: loginBody.toJson(),
    );

    // Trả về AuthResponse sau khi map từ response
    return User.fromJson(response.data);
  }

  // Hàm xử lý đăng ký
  Future<void> register(RegisterBody registerBody) async {
    // Chuyển loginBody thành JSON
    await _dio.post(
      '/auth/register',
      data: registerBody.toJson(),
    );
  }

  // Hàm xử lý kích hoạt tài khoản
  Future<void> activeEmail(ActiveEmailBody activeEmailBody) async {
    // Chuyển loginBody thành JSON
    await _dio.post(
      '/auth/active-email',
      data: activeEmailBody.toJson(),
    );
  }
}
