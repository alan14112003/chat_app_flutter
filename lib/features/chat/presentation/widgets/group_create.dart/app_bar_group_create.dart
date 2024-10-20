import 'package:flutter/material.dart';

class AppBarGroupCreate extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback group_create_button;

  const AppBarGroupCreate({super.key, required this.group_create_button});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Nhóm mới'),
      backgroundColor: Colors.blueAccent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(icon: Icon(Icons.create), onPressed: group_create_button),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight); // Chiều cao của AppBar
}
