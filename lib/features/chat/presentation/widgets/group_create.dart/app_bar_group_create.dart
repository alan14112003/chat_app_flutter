import 'package:flutter/material.dart';

class AppBarGroupCreate extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback group_create_button;

  const AppBarGroupCreate({super.key, required this.group_create_button});

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
        title: Text(
          'Nhóm mới',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(icon: Icon(Icons.create), onPressed: group_create_button),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
