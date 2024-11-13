import 'package:chat_app_flutter/core/common/cubit/app_auth/app_auth_cubit.dart';
import 'package:chat_app_flutter/core/common/usecase/app_auth/get_user_logged_in.dart';
import 'package:chat_app_flutter/core/common/usecase/app_auth/set_user_logged_in.dart';
import 'package:chat_app_flutter/core/common/usecase/app_auth/set_user_logged_out.dart';
import 'package:chat_app_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app_flutter/features/auth/data/sources/auth_local_data_source.dart';
import 'package:chat_app_flutter/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:chat_app_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app_flutter/features/auth/domain/usecases/active_email_usecase.dart';
import 'package:chat_app_flutter/features/auth/domain/usecases/login_usecase.dart';
import 'package:chat_app_flutter/features/auth/domain/usecases/register_usecase.dart';
import 'package:chat_app_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app_flutter/features/auth/presentation/cubit/auth_active_email/auth_active_email_cubit.dart';
import 'package:chat_app_flutter/features/auth/presentation/cubit/auth_login/auth_login_cubit.dart';
import 'package:chat_app_flutter/features/auth/presentation/cubit/auth_register/auth_register_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart';

void authDependencies(GetIt serviceLocator) {
  // Data Source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        dio: serviceLocator(),
      ),
    )
    ..registerFactory<AuthLocalDataSource>(
      () => AuthLocalDataSource(
        preferences: serviceLocator(),
      ),
    )

    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: serviceLocator(),
        authLocalDataSource: serviceLocator(),
      ),
    )

    // Use Cases
    ..registerFactory<LoginUseCase>(
      () => LoginUseCase(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory<SetUserLoggedIn>(
      () => SetUserLoggedIn(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory<GetUserLoggedIn>(
      () => GetUserLoggedIn(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory<SetUserLoggedOut>(
      () => SetUserLoggedOut(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory<RegisterUsecase>(
      () => RegisterUsecase(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory<ActiveEmailUsecase>(
      () => ActiveEmailUsecase(
        authRepository: serviceLocator(),
      ),
    )

    // Bloc
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUseCase: serviceLocator(),
        registerUsecase: serviceLocator(),
        activeEmailUsecase: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => AuthLoginCubit(),
    )
    ..registerFactory(
      () => AuthRegisterCubit(),
    )
    ..registerFactory(
      () => AuthActiveEmailCubit(),
    )
    ..registerFactory<AppAuthCubit>(
      () => AppAuthCubit(
        setUserLoggedIn: serviceLocator(),
        getUserLoggedIn: serviceLocator(),
        setUserLoggedOut: serviceLocator(),
        socket: serviceLocator<Socket>(),
      ),
    );
}
