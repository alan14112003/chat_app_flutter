part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

final class RegisterButtonPressed extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final int gender;

  const RegisterButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gender,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        gender,
      ];
}

final class ActiveEmailEvent extends AuthEvent {
  final String code;
  final String email;

  const ActiveEmailEvent({
    required this.code,
    required this.email,
  });

  @override
  List<Object?> get props => [code, email];
}
