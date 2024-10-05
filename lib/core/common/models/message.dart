import 'package:chat_app_flutter/core/common/models/reaction.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final int? id;
  final String? chatId;
  final String? text;
  final String? file;
  final String? image;
  final int? type;
  final bool? isRecall;
  final bool? isPinned;
  final String? createdAt;
  final User? sender;
  final Message? reply;
  final List<Reaction>? reactions;
  final List<User>? seens;

  const Message({
    this.id,
    this.chatId,
    this.text,
    this.file,
    this.image,
    this.type,
    this.isRecall,
    this.isPinned,
    this.createdAt,
    this.sender,
    this.reply,
    this.reactions,
    this.seens,
  });

  Message copyWith({
    int? id,
    String? userId,
    String? chatId,
    String? text,
    String? file,
    String? image,
    int? type,
    int? replyId,
    bool? isRecall,
    bool? isPinned,
    String? createdAt,
    String? updatedAt,
    User? sender,
    Message? reply,
    List<Reaction>? reactions,
    List<User>? seens,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      text: text ?? this.text,
      file: file ?? this.file,
      image: image ?? this.image,
      type: type ?? this.type,
      isRecall: isRecall ?? this.isRecall,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt ?? this.createdAt,
      sender: sender ?? this.sender,
      reply: reply ?? this.reply,
      reactions: reactions ?? this.reactions,
      seens: seens ?? this.seens,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'text': text,
      'file': file,
      'image': image,
      'type': type,
      'isRecall': isRecall,
      'isPinned': isPinned,
      'createdAt': createdAt,
      'sender': sender?.toJson(),
      'reply': reply,
      'reactions': reactions
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList(),
      'seens':
          seens?.map<Map<String, dynamic>>((data) => data.toJson()).toList(),
    };
  }

  static Message fromJson(Map<String, Object?> json) {
    return Message(
      id: json['id'] == null ? null : json['id'] as int,
      chatId: json['chatId'] == null ? null : json['chatId'] as String,
      text: json['text'] == null ? null : json['text'] as String,
      file: json['file'] == null ? null : json['file'] as String,
      image: json['image'] == null ? null : json['image'] as String,
      type: json['type'] == null ? null : json['type'] as int,
      isRecall: json['isRecall'] == null ? null : json['isRecall'] as bool,
      isPinned: json['isPinned'] == null ? null : json['isPinned'] as bool,
      createdAt: json['createdAt'] == null ? null : json['createdAt'] as String,
      sender: json['sender'] == null
          ? null
          : User.fromJson(json['sender'] as Map<String, Object?>),
      reply: json['reply'] is Map<String, dynamic>
          ? Message.fromJson(json['reply'] as Map<String, Object?>)
          : null,
      reactions: json['reactions'] == null
          ? null
          : (json['reactions'] as List)
              .map<Reaction>(
                  (data) => Reaction.fromJson(data as Map<String, Object?>))
              .toList(),
      seens: json['seens'] == null
          ? null
          : (json['seens'] as List)
              .map<User>((data) => User.fromJson(data as Map<String, Object?>))
              .toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        chatId,
        text,
        file,
        image,
        type,
        isRecall,
        isPinned,
        createdAt,
        sender,
        reply,
        reactions,
        seens,
      ];

  @override
  bool get stringify => true;
}
