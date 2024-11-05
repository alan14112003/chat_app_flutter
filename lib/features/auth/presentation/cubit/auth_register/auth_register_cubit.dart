import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'auth_register_state.dart';

class AuthRegisterCubit extends Cubit<AuthRegisterState> {
  AuthRegisterCubit() : super(AuthRegisterState.initial());

  void firstNameChanged(String firstName) {
    emit(state.copyWith(firstName: firstName));
  }

  void lastNameChanged(String lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void confirmPasswordChanged(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void genderChanged(int gender) {
    emit(state.copyWith(gender: gender));
  }

  void toggleIsSubmitted([bool isSubmitted = false]) {
    final isValidFirstName = state.firstName.isNotEmpty;
    final isValidLastName = state.lastName.isNotEmpty;
    final isValidEmail = EmailValidator.validate(state.email);
    final isValidPassword = state.password.length >= 3;
    final isValidConfirmPassword = state.confirmPassword == state.password;

    emit(
      state.copyWith(
        isSubmitted: isSubmitted,
        isValidFirstName: isValidFirstName,
        isValidLastName: isValidLastName,
        isValidEmail: isValidEmail,
        isValidPassword: isValidPassword,
        isValidConfirmPassword: isValidConfirmPassword,
      ),
    );
  }
}
