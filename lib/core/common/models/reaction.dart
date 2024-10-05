import 'package:chat_app_flutter/core/common/models/emoji.dart';
import 'package:chat_app_flutter/core/common/models/user_info.dart';
import 'package:equatable/equatable.dart';

class Reaction extends Equatable {
  final String? userId;
  final int? messageId;
  final int? emojiId;
  final UserInfo? sender;
  final Emoji? emoji;
  const Reaction({
    this.userId,
    this.messageId,
    this.emojiId,
    this.sender,
    this.emoji,
  });

  Reaction copyWith({
    String? userId,
    int? messageId,
    int? emojiId,
    UserInfo? sender,
    Emoji? emoji,
  }) {
    return Reaction(
      userId: userId ?? this.userId,
      messageId: messageId ?? this.messageId,
      emojiId: emojiId ?? this.emojiId,
      sender: sender ?? this.sender,
      emoji: emoji ?? this.emoji,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'userId': userId,
      'messageId': messageId,
      'emojiId': emojiId,
      'sender': sender?.toJson(),
      'emoji': emoji?.toJson(),
    };
  }

  static Reaction fromJson(Map<String, Object?> json) {
    return Reaction(
      userId: json['userId'] == null ? null : json['userId'] as String,
      messageId: json['messageId'] == null ? null : json['messageId'] as int,
      emojiId: json['emojiId'] == null ? null : json['emojiId'] as int,
      sender: json['sender'] == null
          ? null
          : UserInfo.fromJson(json['sender'] as Map<String, Object?>),
      emoji: json['emoji'] == null
          ? null
          : Emoji.fromJson(json['emoji'] as Map<String, Object?>),
    );
  }

  @override
  List<Object?> get props => [
        userId,
        messageId,
        emojiId,
        sender,
        emoji,
      ];

  @override
  bool? get stringify => true;
}
