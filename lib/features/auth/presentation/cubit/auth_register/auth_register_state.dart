part of 'auth_register_cubit.dart';

class AuthRegisterState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final int gender;
  final bool isValidFirstName;
  final bool isValidLastName;
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isValidConfirmPassword;
  final bool isSubmitted;

  const AuthRegisterState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.gender,
    required this.isValidFirstName,
    required this.isValidLastName,
    required this.isValidEmail,
    required this.isValidPassword,
    required this.isValidConfirmPassword,
    required this.isSubmitted,
  });

  factory AuthRegisterState.initial() {
    return const AuthRegisterState(
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      confirmPassword: '',
      gender: 0, // Assuming 0 as a default value for gender
      isValidFirstName: true,
      isValidLastName: true,
      isValidEmail: true,
      isValidPassword: true,
      isValidConfirmPassword: true,
      isSubmitted: false,
    );
  }

  AuthRegisterState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    int? gender,
    bool? isValidFirstName,
    bool? isValidLastName,
    bool? isValidEmail,
    bool? isValidPassword,
    bool? isValidConfirmPassword,
    bool? isSubmitted,
  }) {
    return AuthRegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      gender: gender ?? this.gender,
      isValidFirstName: isValidFirstName ?? this.isValidFirstName,
      isValidLastName: isValidLastName ?? this.isValidLastName,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isValidConfirmPassword:
          isValidConfirmPassword ?? this.isValidConfirmPassword,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        confirmPassword,
        gender,
        isValidFirstName,
        isValidLastName,
        isValidEmail,
        isValidPassword,
        isValidConfirmPassword,
        isSubmitted,
      ];
}
