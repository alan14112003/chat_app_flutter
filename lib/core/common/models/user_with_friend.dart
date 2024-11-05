import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:equatable/equatable.dart';

class UserWithFriend extends Equatable {
  final User user;
  final Friend? friend;

  const UserWithFriend({
    required this.user,
    required this.friend,
  });

  UserWithFriend copyWith({
    User? user,
    Friend? friend,
  }) {
    return UserWithFriend(
      user: user ?? this.user,
      friend: friend ?? this.friend,
    );
  }

  Map<String, Object?> toJson() {
    return {
      ...user.toJson(),
      'friend': friend?.toJson(),
    };
  }

  static UserWithFriend fromJson(Map<String, Object?> json) {
    return UserWithFriend(
      user: User.fromJson(json),
      friend: json['friend'] != null
          ? Friend.fromJson(json['friend'] as Map<String, Object?>)
          : null,
    );
  }

  @override
  List<Object?> get props => [user, friend];

  @override
  bool? get stringify => true;
}
