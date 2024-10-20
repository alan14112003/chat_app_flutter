import 'package:chat_app_flutter/features/chat/domain/types/chat_user.dart';
import 'package:chat_app_flutter/features/message/presentation/screens/message_screen.dart';
import 'package:flutter/material.dart';

class UserListGroupCreate extends StatefulWidget {
  final List<ChatUsers> chatUsers;

  const UserListGroupCreate({super.key, required this.chatUsers});

  @override
  _UserListGroupCreateState createState() => _UserListGroupCreateState();
}

class _UserListGroupCreateState extends State<UserListGroupCreate> {
  // Tạo một danh sách để quản lý trạng thái của các checkbox
  late List<bool> _checked;

  @override
  void initState() {
    super.initState();
    // Khởi tạo danh sách với giá trị false cho tất cả checkbox ban đầu
    _checked = List<bool>.filled(widget.chatUsers.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.chatUsers.length,
      itemBuilder: (context, index) {
        // Truy cập đối tượng ChatUser tại vị trí index
        ChatUsers user = widget.chatUsers[index];
        user.isMessageRead = (index == 0 || index == 2) ? true : false;

        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MessageScreen(
                chatId: '3bf8c507-8ef0-4931-ac15-92672195cb20',
              );
            }));
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
                              Text(
                                user.name,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade500),
                              ),
                              SizedBox(height: 6),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Checkbox(
                  activeColor: Colors.blueAccent,
                  value: _checked[index],
                  onChanged: (bool? value) {
                    setState(() {
                      _checked[index] = value ?? false;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
