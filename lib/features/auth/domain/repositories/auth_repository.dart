import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/features/auth/data/sources/active_email_body.dart';
import 'package:chat_app_flutter/features/auth/data/sources/auth_body.dart';
import 'package:chat_app_flutter/features/auth/data/sources/register_body.dart';

// Interface cho AuthRepository
abstract interface class AuthRepository {
  // Hàm đăng nhập, trả về đối tượng [User] khi đăng nhập thành công
  Future<User> login(LoginBody loginBody);
  Future<void> setUserLoggedIn(User user);
  User? getUserLoggedIn();
  Future<void> logout();
  Future<void> register(RegisterBody registerBody);
  Future<void> activeEmail(ActiveEmailBody activeEmailBody);
}
