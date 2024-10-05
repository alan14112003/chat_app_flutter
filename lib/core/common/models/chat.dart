import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String? id;
  final String? groupName;
  final bool? isGroup;
  final Message? lastMsg;
  final List<User>? members;
  final User? adm;

  const Chat({
    this.id,
    this.groupName,
    this.isGroup,
    this.lastMsg,
    this.members,
    this.adm,
  });

  Chat copyWith({
    String? id,
    String? groupName,
    bool? isGroup,
    Message? lastMsg,
    List<User>? members,
    User? adm,
  }) {
    return Chat(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      isGroup: isGroup ?? this.isGroup,
      lastMsg: lastMsg ?? this.lastMsg,
      members: members ?? this.members,
      adm: adm ?? this.adm,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'groupName': groupName,
      'isGroup': isGroup,
      'lastMsg': lastMsg?.toJson(),
      'members':
          members?.map<Map<String, dynamic>>((data) => data.toJson()).toList(),
      'adm': adm
    };
  }

  static Chat fromJson(Map<String, Object?> json) {
    return Chat(
        id: json['id'] == null ? null : json['id'] as String,
        groupName: json['groupName'] as dynamic,
        isGroup: json['isGroup'] == null ? null : json['isGroup'] as bool,
        lastMsg: json['lastMsg'] == null
            ? null
            : Message.fromJson(json['lastMsg'] as Map<String, Object?>),
        members: json['members'] == null
            ? null
            : (json['members'] as List)
                .map<User>(
                  (data) => User.fromJson(data as Map<String, Object?>),
                )
                .toList(),
        adm: json['adm'] as dynamic);
  }

  @override
  List<Object?> get props => [id, groupName, isGroup, lastMsg, members, adm];

  @override
  bool? get stringify => true;
}
