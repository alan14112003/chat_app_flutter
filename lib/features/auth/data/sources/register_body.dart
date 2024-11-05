import 'package:equatable/equatable.dart';

class RegisterBody extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final int gender;

  const RegisterBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gender,
  });

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        gender,
      ];

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'gender': gender,
    };
  }
}
