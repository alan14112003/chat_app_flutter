import 'package:equatable/equatable.dart';

class ActiveEmailBody extends Equatable {
  final String code;
  final String email;

  const ActiveEmailBody({
    required this.code,
    required this.email,
  });

  @override
  List<Object?> get props => [code, email];

  @override
  bool? get stringify => true;

  // Phương thức chuyển đổi thành JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'email': email,
    };
  }
}
