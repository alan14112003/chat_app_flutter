import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'auth_login_state.dart';

class AuthLoginCubit extends Cubit<AuthLoginState> {
  AuthLoginCubit() : super(AuthLoginState.initial());

  void emailChanged(String email) {
    final isValidEmail = EmailValidator.validate(email);
    emit(state.copyWith(email: email, isValidEmail: isValidEmail));
  }

  void passwordChanged(String password) {
    final isValidPassword = password.length >= 6;
    emit(state.copyWith(password: password, isValidPassword: isValidPassword));
  }

  bool isFormValid() {
    final isValidEmail = EmailValidator.validate(state.email);
    final isValidPassword = state.password.length >= 6;

    emit(state.copyWith(
      isValidEmail: isValidEmail,
      isValidPassword: isValidPassword,
    ));

    return isValidEmail && isValidPassword;
  }
}
