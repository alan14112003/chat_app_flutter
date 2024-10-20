import 'package:flutter/material.dart';

class AppBarChat extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback group_button;

  const AppBarChat({super.key, required this.group_button});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Đoạn chat'),
      backgroundColor: Colors.blueAccent,
      actions: [
        IconButton(
          icon: Icon(Icons.group),
          onPressed: group_button
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // Chiều cao của AppBar
}
