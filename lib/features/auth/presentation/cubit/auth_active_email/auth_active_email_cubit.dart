import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'auth_active_email_state.dart';

class AuthActiveEmailCubit extends Cubit<AuthActiveEmailState> {
  AuthActiveEmailCubit() : super(AuthActiveEmailState.initial());

  void codeChanged(String code) {
    emit(state.copyWith(code: code));
  }

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void toggleIsSubmitted([bool isSubmitted = false]) {
    final isValidCode = state.code.isNotEmpty;
    final isValidEmail = EmailValidator.validate(state.email);

    emit(
      state.copyWith(
        isSubmitted: isSubmitted,
        isValidCode: isValidCode,
        isValidEmail: isValidEmail,
      ),
    );
  }
}
