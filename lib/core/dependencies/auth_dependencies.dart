import 'package:chat_app_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app_flutter/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:chat_app_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app_flutter/features/auth/domain/usecases/login_usecase.dart';
import 'package:chat_app_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

void authDependencies(GetIt serviceLocator) {
  // Data Source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(dio: serviceLocator()),
    )

    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: serviceLocator(),
      ),
    )

    // Use Cases
    ..registerFactory<LoginUseCase>(
      () => LoginUseCase(
        authRepository: serviceLocator(),
      ),
    )

    // Bloc
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUseCase: serviceLocator(),
      ),
    );
}
