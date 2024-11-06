import 'package:flutter/material.dart';

class AppBarChat extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback group_button;

  const AppBarChat({super.key, required this.group_button});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Đoạn chat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: Icon(Icons.group), onPressed: group_button),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
