import 'package:flutter/material.dart';

class AppBarInviteContact extends StatelessWidget
    implements PreferredSizeWidget {
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
