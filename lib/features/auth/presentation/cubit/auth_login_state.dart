part of 'auth_login_cubit.dart';

class AuthLoginState extends Equatable {
  final String email;
  final String password;
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitted;

  const AuthLoginState({
    required this.email,
    required this.password,
    required this.isValidEmail,
    required this.isValidPassword,
    required this.isSubmitted,
  });

  factory AuthLoginState.initial() {
    return const AuthLoginState(
      email: '',
      password: '',
      isValidEmail: true,
      isValidPassword: true,
      isSubmitted: false,
    );
  }

  AuthLoginState copyWith({
    String? email,
    String? password,
    bool? isValidEmail,
    bool? isValidPassword,
    bool? isSubmitted,
  }) {
    return AuthLoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isValidEmail,
        isValidPassword,
        isSubmitted,
      ];
}
