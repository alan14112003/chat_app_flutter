import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/cubit/app_auth/app_auth_cubit.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/features/auth/domain/usecases/active_email_usecase.dart';
import 'package:chat_app_flutter/features/auth/domain/usecases/login_usecase.dart';
import 'package:chat_app_flutter/features/auth/domain/usecases/register_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final AppAuthCubit _appAuthCubit;
  final RegisterUsecase _registerUsecase;
  final ActiveEmailUsecase _activeEmailUsecase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required AppAuthCubit appAuthCubit,
    required RegisterUsecase registerUsecase,
    required ActiveEmailUsecase activeEmailUsecase,
  })  : _loginUseCase = loginUseCase,
        _appAuthCubit = appAuthCubit,
        _registerUsecase = registerUsecase,
        _activeEmailUsecase = activeEmailUsecase,
        super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
    on<ActiveEmailEvent>(_onActiveEmail);
  }

  FutureOr<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _loginUseCase.call(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        emit(AuthFailure(error: failure.message));
      },
      (user) {
        emit(AuthSuccess(user: user));

        // Lưu thông tin người dùng
        _appAuthCubit.setUserLoggedIn(user);
      },
    );
  }

  FutureOr<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _registerUsecase.call(RegisterParams(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      gender: event.gender,
    ));

    result.fold(
      (failure) {
        emit(AuthFailure(error: failure.message));
      },
      (_) {
        emit(AuthRegisterSuccess());
      },
    );
  }

  FutureOr<void> _onActiveEmail(
    ActiveEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _activeEmailUsecase.call(
      ActiveEmailParams(
        code: event.code,
        email: event.email,
      ),
    );

    result.fold(
      (failure) {
        emit(AuthFailure(error: failure.message));
      },
      (_) {
        emit(ActiveEmailSuccess());
      },
    );
  }
}
