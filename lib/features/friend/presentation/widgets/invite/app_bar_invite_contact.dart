import 'package:flutter/material.dart';

class AppBarInviteContact extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;

  const AppBarInviteContact({super.key, required this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: leading,
      title: Text(
        'Lời mời kết bạn',
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/suggest');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('Đề xuất kết bạn', style: TextStyle(fontSize: 12),),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}