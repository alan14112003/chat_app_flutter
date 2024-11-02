
import 'package:chat_app_flutter/features/friend/presentation/widgets/navigation/bottom_navigation_bar.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/suggest/app_bar_suggest_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/suggest/search_bar_suggest_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/suggest/user_list_suggest.dart';
import 'package:flutter/material.dart';


class SuggestScreen extends StatefulWidget {
  const SuggestScreen({super.key});

  @override
  _SuggestScreenState createState() => _SuggestScreenState();
}

class _SuggestScreenState extends State<SuggestScreen> {
  final List<Map<String, dynamic>> users = [
    {
      "name": "Lê Thị Đan Liên",
      "mutualFriends": 266,
      "avatar": "assets/avatar1.png",
    },
    {
      "name": "Too Uyenn",
      "mutualFriends": 266,
      "avatar": "assets/avatar2.png",
    },
  ];

  int _currentIndex = 1;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          padding: const EdgeInsets.only(top: 22.0, bottom: 6.0),
          child: AppBarSuggestContact(),
        ),
      ),
      body: Column(
        children: [
          SearchBarSuggestContact(),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return UserListSuggest(user: users[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 0) {
              Navigator.pushReplacementNamed(context, '/chats');
            } else if (_currentIndex == 1) {
              Navigator.pushReplacementNamed(context, '/contacts');
            } else if (_currentIndex == 2) {
              Navigator.pushReplacementNamed(context, '/settings');
            }
          });
        },
      ),
    );
  }

}
