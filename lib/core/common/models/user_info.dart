import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String? fullName;
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? email;

  const UserInfo({
    this.fullName,
    this.id,
    this.firstName,
    this.lastName,
    this.avatar,
    this.email,
  });

  UserInfo copyWith({
    String? fullName,
    String? id,
    String? firstName,
    String? lastName,
    String? avatar,
    String? email,
  }) {
    return UserInfo(
      fullName: fullName ?? this.fullName,
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'fullName': fullName,
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
      'email': email,
    };
  }

  static UserInfo fromJson(Map<String, Object?> json) {
    return UserInfo(
      fullName: json['fullName'] == null ? null : json['fullName'] as String,
      id: json['id'] == null ? null : json['id'] as String,
      firstName: json['firstName'] == null ? null : json['firstName'] as String,
      lastName: json['lastName'] == null ? null : json['lastName'] as String,
      avatar: json['avatar'] as dynamic,
      email: json['email'] == null ? null : json['email'] as String,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        id,
        firstName,
        lastName,
        avatar,
        email,
      ];

  @override
  bool? get stringify => true;
}
