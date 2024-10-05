import 'package:chat_app_flutter/core/common/models/reaction.dart';
import 'package:chat_app_flutter/core/common/models/user_info.dart';
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final int? id;
  final String? userId;
  final String? chatId;
  final String? text;
  final dynamic file;
  final dynamic image;
  final int? type;
  final int? replyId;
  final bool? isRecall;
  final bool? isPinned;
  final String? createdAt;
  final String? updatedAt;
  final UserInfo? sender;
  final Message? reply;
  final List<Reaction>? reactions;
  final List<UserInfo>? seens;
  const Message({
    this.id,
    this.userId,
    this.chatId,
    this.text,
    this.file,
    this.image,
    this.type,
    this.replyId,
    this.isRecall,
    this.isPinned,
    this.createdAt,
    this.updatedAt,
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
    dynamic file,
    dynamic image,
    int? type,
    int? replyId,
    bool? isRecall,
    bool? isPinned,
    String? createdAt,
    String? updatedAt,
    UserInfo? sender,
    Message? reply,
    List<Reaction>? reactions,
    List<UserInfo>? seens,
  }) {
    return Message(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      chatId: chatId ?? this.chatId,
      text: text ?? this.text,
      file: file ?? this.file,
      image: image ?? this.image,
      type: type ?? this.type,
      replyId: replyId ?? this.replyId,
      isRecall: isRecall ?? this.isRecall,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sender: sender ?? this.sender,
      reply: reply ?? this.reply,
      reactions: reactions ?? this.reactions,
      seens: seens ?? this.seens,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'userId': userId,
      'chatId': chatId,
      'text': text,
      'file': file,
      'image': image,
      'type': type,
      'replyId': replyId,
      'isRecall': isRecall,
      'isPinned': isPinned,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
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
      userId: json['userId'] == null ? null : json['userId'] as String,
      chatId: json['chatId'] == null ? null : json['chatId'] as String,
      text: json['text'] == null ? null : json['text'] as String,
      file: json['file'] as dynamic,
      image: json['image'] as dynamic,
      type: json['type'] == null ? null : json['type'] as int,
      replyId: json['replyId'] == null ? null : json['replyId'] as int,
      isRecall: json['isRecall'] == null ? null : json['isRecall'] as bool,
      isPinned: json['isPinned'] == null ? null : json['isPinned'] as bool,
      createdAt: json['createdAt'] == null ? null : json['createdAt'] as String,
      updatedAt: json['updatedAt'] == null ? null : json['updatedAt'] as String,
      sender: json['sender'] == null
          ? null
          : UserInfo.fromJson(json['sender'] as Map<String, Object?>),
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
              .map<UserInfo>(
                  (data) => UserInfo.fromJson(data as Map<String, Object?>))
              .toList(),
    );
  }

  // @override
  // String toString() {
  //   return '''Message(
  //               id:$id,
  // userId:$userId,
  // chatId:$chatId,
  // text:$text,
  // file:$file,
  // image:$image,
  // type:$type,
  // replyId:$replyId,
  // isRecall:$isRecall,
  // isPinned:$isPinned,
  // createdAt:$createdAt,
  // updatedAt:$updatedAt,
  // sender:${sender.toString()},
  // reply:$reply,
  // reactions:${reactions.toString()},
  // seens:${seens.toString()}
  //   ) ''';
  // }

  @override
  List<Object?> get props => [
        id,
        userId,
        chatId,
        text,
        file,
        image,
        type,
        replyId,
        isRecall,
        isPinned,
        createdAt,
        updatedAt,
        sender,
        reply,
        reactions,
        seens,
      ];

  @override
  bool get stringify => true;
}
