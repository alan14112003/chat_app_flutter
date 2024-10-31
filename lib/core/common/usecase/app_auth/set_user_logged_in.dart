import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SetUserLoggedIn implements UseCase<void, User> {
  final AuthRepository _authRepository;

  SetUserLoggedIn({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(User user) async {
    try {
      await _authRepository.setUserLoggedIn(user);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
