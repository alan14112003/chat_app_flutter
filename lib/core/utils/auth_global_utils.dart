import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/dependencies/init_dependencies.dart';
import 'package:chat_app_flutter/features/auth/domain/repositories/auth_repository.dart';

class AuthGlobalUtils {
  static User getAuth() {
    return serviceLocator<AuthRepository>().getUserLoggedIn() ?? User();
  }
}
