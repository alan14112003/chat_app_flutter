import 'package:chat_app_flutter/features/chat/domain/types/chat_user.dart';
import 'package:chat_app_flutter/features/chat/presentation/screens/group_create_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/chat/app_bar_chat.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/chat/chat_user_list.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/chat/search_chat.dart';
import 'package:chat_app_flutter/features/friend/presentation/screens/contact_screen.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => ChatScreen(),
      );

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarChat(
          group_button: () {
            Navigator.push(context, GroupCreateScreen.route());
          },
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              SearchBarChat(),
              // Thêm nhiều widget khác vào ListView để kiểm tra khả năng cuộn
              ChatUserList(
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
        bottomNavigationBar: BottomNavigation(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              if (_currentIndex == 0) {
                Navigator.push(context, ChatScreen.route());
              } else if (_currentIndex == 1) {
                // Navigator.push(context, ContactScreen.route());
              } else if (_currentIndex == 2) {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //     return const SettingScreen();
                // }));
              }
            });
          },
        ),
      ),
    );
  }
}
