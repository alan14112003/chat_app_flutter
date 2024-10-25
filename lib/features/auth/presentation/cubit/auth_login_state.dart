part of 'auth_login_cubit.dart';

class AuthLoginState extends Equatable {
  final String email;
  final String password;
  final bool isValidEmail;
  final bool isValidPassword;

  const AuthLoginState({
    required this.email,
    required this.password,
    required this.isValidEmail,
    required this.isValidPassword,
  });

  factory AuthLoginState.initial() {
    return const AuthLoginState(
      email: '',
      password: '',
      isValidEmail: true,
      isValidPassword: true,
    );
  }

  AuthLoginState copyWith({
    String? email,
    String? password,
    bool? isValidEmail,
    bool? isValidPassword,
  }) {
    return AuthLoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
    );
  }

  @override
  List<Object?> get props => [email, password, isValidEmail, isValidPassword];
}
