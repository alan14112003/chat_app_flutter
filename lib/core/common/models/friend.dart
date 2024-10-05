import 'package:chat_app_flutter/core/common/models/user_info.dart';
import 'package:equatable/equatable.dart';

class Friend extends Equatable {
  final int? status;
  final String? userFrom;
  final String? userTo;
  final UserInfo? from;
  final UserInfo? to;

  const Friend({
    this.status,
    this.from,
    this.to,
    this.userFrom,
    this.userTo,
  });

  Friend copyWith({
    int? status,
    String? userFrom,
    String? userTo,
    UserInfo? from,
    UserInfo? to,
  }) {
    return Friend(
      status: status ?? this.status,
      userFrom: userFrom ?? this.userFrom,
      userTo: userTo ?? this.userTo,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'status': status,
      'userFrom': userFrom,
      'userTo': userTo,
      'from': from?.toJson(),
      'to': to?.toJson(),
    };
  }

  static Friend fromJson(Map<String, Object?> json) {
    return Friend(
      status: json['status'] == null ? null : json['status'] as int,
      userFrom: json['userFrom'] == null ? null : json['userFrom'] as String,
      userTo: json['userTo'] == null ? null : json['userTo'] as String,
      from: json['from'] == null
          ? null
          : UserInfo.fromJson(json['from'] as Map<String, Object?>),
      to: json['to'] == null
          ? null
          : UserInfo.fromJson(json['to'] as Map<String, Object?>),
    );
  }

  @override
  List<Object?> get props => [status, userFrom, userTo, from, to];

  @override
  bool? get stringify => true;
}
