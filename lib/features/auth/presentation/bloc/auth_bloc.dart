import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/cubit/app_auth/app_auth_cubit.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/features/auth/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final AppAuthCubit _appAuthCubit;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required AppAuthCubit appAuthCubit,
  })  : _loginUseCase = loginUseCase,
        _appAuthCubit = appAuthCubit,
        super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
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
}
