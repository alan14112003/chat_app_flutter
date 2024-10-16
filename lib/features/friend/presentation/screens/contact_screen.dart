import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/app_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/list_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/search_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/navigation/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';


class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onInviteFriend: () {
          Navigator.pushNamed(context, '/suggest');
        },
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SearchBarContact(),
            ContactList(
              contacts: [
                {'name': 'Ánh', 'letter': 'A'},
                {'name': 'An', 'letter': 'A'},
                {'name': 'Bạn Liên', 'letter': 'B'},
                {'name': 'Bạn Linh', 'letter': 'B'},
                {'name': 'Ly A12', 'letter': 'L'},
                {'name': 'Cindy', 'letter': 'C'},
                {'name': 'Daisy', 'letter': 'D'},
                {'name': 'Diana', 'letter': 'D'},
              ],
            ),
          ],
        ),
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
