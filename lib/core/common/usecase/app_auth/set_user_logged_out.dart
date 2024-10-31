import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SetUserLoggedOut implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  // SetUserLoggedOut(this.authRepository);
  SetUserLoggedOut({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    try {
      final userLoggedIn = _authRepository.getUserLoggedIn();
      await _authRepository.logout();
      return right(userLoggedIn);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
