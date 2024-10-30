import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/features/auth/data/sources/auth_body.dart';

// Interface cho AuthRepository
abstract interface class AuthRepository {
  // Hàm đăng nhập, trả về đối tượng [User] khi đăng nhập thành công
  Future<User> login(LoginBody loginBody);
}
