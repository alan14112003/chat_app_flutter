import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:chat_app_flutter/features/auth/data/sources/auth_body.dart';
import 'package:chat_app_flutter/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
  }) : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<User> login(LoginBody loginBody) async {
    try {
      // Gọi hàm login từ remote data source
      final user = await _authRemoteDataSource.login(loginBody);
      // Trả về đối tượng user sau khi đăng nhập thành công
      return user;
    } catch (e) {
      // Xử lý các lỗi, ví dụ: in ra lỗi hoặc throw lỗi lên trên để xử lý
      throw Exception('Đăng nhập thất bại: $e');
    }
  }
}
