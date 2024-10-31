import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/features/auth/data/sources/auth_local_data_source.dart';
import 'package:chat_app_flutter/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:chat_app_flutter/features/auth/data/sources/auth_body.dart';
import 'package:chat_app_flutter/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required AuthLocalDataSource authLocalDataSource,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _authLocalDataSource = authLocalDataSource;

  @override
  Future<User> login(LoginBody loginBody) async {
    // Gọi hàm login từ remote data source
    final user = await _authRemoteDataSource.login(loginBody);
    // Trả về đối tượng user sau khi đăng nhập thành công
    return user;
  }

  @override
  Future<void> setUserLoggedIn(User user) async {
    await _authLocalDataSource.setUserLoggedIn(user, user.accessToken!);
  }

  @override
  User? getUserLoggedIn() {
    return _authLocalDataSource.getUserLoggedIn();
  }

  @override
  Future<void> logout() async {
    await _authLocalDataSource.clearUser();
  }
}
