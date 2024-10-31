import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUserLoggedIn implements UseCase<User?, NoParams> {
  final AuthRepository _authRepository;

  GetUserLoggedIn({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return right(_authRepository.getUserLoggedIn());
  }
}
