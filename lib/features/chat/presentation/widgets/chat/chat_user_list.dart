import 'package:chat_app_flutter/core/common/models/chat.dart';
import 'package:chat_app_flutter/core/utils/chat_global_utils.dart';
import 'package:chat_app_flutter/core/utils/format_time_difference.dart';
import 'package:chat_app_flutter/core/utils/message_global_utils.dart';
import 'package:chat_app_flutter/features/message/presentation/screens/message_screen.dart';
import 'package:flutter/material.dart';

class ChatUserList extends StatelessWidget {
  final List<Chat> chats;

  const ChatUserList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        final lastMsg = chat.lastMsg;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MessageScreen.route(chat.id!),
            );
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 10,
              bottom: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: <Widget>[
                      if (ChatGlobalUtils.isGroupChat(chat))
                        CircleAvatar(
                          maxRadius: 30,
                          child: Text(
                            ChatGlobalUtils.getNameAvatarGroupChat(chat),
                          ),
                        )
                      else
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            ChatGlobalUtils.getChatFriend(
                                  chat,
                                ).avatar ??
                                '',
                          ),
                          maxRadius: 30,
                        ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                ChatGlobalUtils.isGroupChat(chat)
                                    ? chat.groupName!
                                    : ChatGlobalUtils.getChatFriend(chat)
                                        .fullName!,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 6),
                              if (lastMsg != null) ...[
                                Text(
                                  '${lastMsg.sender?.firstName}: ${MessageGlobalUtils.getTextRender(lastMsg)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ]
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (lastMsg != null) ...[
                  Text(
                    formatTimeDifference(lastMsg.createdAt!),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
