import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/app_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/list_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/search_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/navigation/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';


class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), 
        child: Container(
          padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
          child: CustomAppBar(
          onInviteFriend: () {
          Navigator.pushNamed(context, '/suggest');
            },
          ), 
        ),
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
