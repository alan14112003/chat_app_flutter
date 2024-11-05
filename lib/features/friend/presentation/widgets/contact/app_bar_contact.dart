import 'package:flutter/material.dart';

class AppBarContact extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onInviteFriend;

  const AppBarContact({super.key, required this.onInviteFriend});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Bạn bè',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 16.0),
            child: ElevatedButton(
              onPressed: onInviteFriend,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Lời mời kết bạn',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
