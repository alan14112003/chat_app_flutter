part of 'auth_active_email_cubit.dart';

class AuthActiveEmailState extends Equatable {
  final String code;
  final String email;
  final bool isValidCode;
  final bool isValidEmail;
  final bool isSubmitted;

  const AuthActiveEmailState({
    required this.code,
    required this.email,
    required this.isValidCode,
    required this.isValidEmail,
    required this.isSubmitted,
  });

  factory AuthActiveEmailState.initial() {
    return const AuthActiveEmailState(
      code: '',
      email: '',
      isValidCode: true,
      isValidEmail: true,
      isSubmitted: false,
    );
  }

  AuthActiveEmailState copyWith({
    String? code,
    String? email,
    bool? isValidCode,
    bool? isValidEmail,
    bool? isSubmitted,
  }) {
    return AuthActiveEmailState(
      code: code ?? this.code,
      email: email ?? this.email,
      isValidCode: isValidCode ?? this.isValidCode,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [
        code,
        email,
        isValidCode,
        isValidEmail,
        isSubmitted,
      ];
}
