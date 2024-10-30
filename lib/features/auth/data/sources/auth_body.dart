import 'package:equatable/equatable.dart';

class LoginBody extends Equatable {
  final String email;
  final String password;

  const LoginBody({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];

  @override
  bool? get stringify => true;

  // Phương thức chuyển đổi thành JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
