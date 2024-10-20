import 'package:chat_app_flutter/features/chat/domain/types/chat_user.dart';
import 'package:chat_app_flutter/features/message/presentation/screens/message_screen.dart';
import 'package:flutter/material.dart';

class ChatUserList extends StatelessWidget {
  final List<ChatUsers> chatUsers;

  const ChatUserList({super.key, required this.chatUsers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: chatUsers.length,
      itemBuilder: (context, index) {
        // Truy cập đối tượng ChatUser tại vị trí index
        ChatUsers user = chatUsers[index];
        user.isMessageRead = (index == 0 || index == 2) ? true : false;

        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MessageScreen.route(
                  '3bf8c507-8ef0-4931-ac15-92672195cb20',
                ));
          },
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage(user.image),
                        maxRadius: 30,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(user.text),
                              SizedBox(height: 6),
                              Text(
                                user.text,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  user.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: user.isMessageRead
                        ? Colors.black
                        : Colors.grey.shade500,
                    fontWeight: user.isMessageRead
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
