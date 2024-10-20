import 'package:chat_app_flutter/features/chat/domain/types/chat_user.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/group_create.dart/app_bar_group_create.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/group_create.dart/search_group_create.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/group_create.dart/user_list_group_create.dart';
import 'package:flutter/material.dart';

class GroupCreateScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => GroupCreateScreen(),
      );

  const GroupCreateScreen({super.key});

  @override
  State<GroupCreateScreen> createState() => _GroupCreateScreenState();
}

class _GroupCreateScreenState extends State<GroupCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarGroupCreate(
          group_create_button: () {
            //Chưa có màn hình nhóm chat
          },
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Nhập tên nhóm',
                    border: InputBorder.none, // Loại bỏ tất cả đường viền
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding: EdgeInsets.all(8.0),
                    focusedBorder: UnderlineInputBorder(
                      // Viền dưới khi được chọn
                      borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2.0), // Viền dưới khi TextField được chọn
                    ),
                  ),
                ),
              ),
              SearchBarGroupCreate(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Gợi ý',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              // Thêm nhiều widget khác vào ListView để kiểm tra khả năng cuộn
              UserListGroupCreate(
                chatUsers: [
                  ChatUsers(
                      name: 'Hòa',
                      text: 'aa',
                      image: 'images/avatar.jpg',
                      time: 'bây giờ',
                      isMessageRead: false),
                  ChatUsers(
                      name: 'A',
                      text: 'aa',
                      image: 'images/avatar.jpg',
                      time: '12:30',
                      isMessageRead: false),
                  ChatUsers(
                      name: 'B',
                      text: 'aa',
                      image: 'images/avatar.jpg',
                      time: 'bây giờ',
                      isMessageRead: false),
                  ChatUsers(
                      name: 'C',
                      text: 'aa',
                      image: 'images/avatar.jpg',
                      time: '3:30',
                      isMessageRead: false),
                  ChatUsers(
                      name: 'D',
                      text: 'aa',
                      image: 'images/avatar.jpg',
                      time: '8:30',
                      isMessageRead: false),
                  ChatUsers(
                      name: 'E',
                      text: 'aa',
                      image: 'images/avatar.jpg',
                      time: '8:30',
                      isMessageRead: false),
                  ChatUsers(
                      name: 'F',
                      text: 'aa',
                      image: 'images/avatar.jpg',
                      time: '8:30',
                      isMessageRead: false),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
