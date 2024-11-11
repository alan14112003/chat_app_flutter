import 'package:flutter/material.dart';

class AppBarSuggestContact extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarSuggestContact({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Tìm kiếm',
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
