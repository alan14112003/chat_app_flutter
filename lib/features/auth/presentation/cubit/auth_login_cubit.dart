import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'auth_login_state.dart';

class AuthLoginCubit extends Cubit<AuthLoginState> {
  AuthLoginCubit() : super(AuthLoginState.initial());

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void toggleIsSubmitted([bool isSubmitted = false]) {
    final isValidEmail = EmailValidator.validate(state.email);
    final isValidPassword = state.password.length >= 6;

    emit(
      state.copyWith(
        isSubmitted: isSubmitted,
        isValidEmail: isValidEmail,
        isValidPassword: isValidPassword,
      ),
    );
  }
}
