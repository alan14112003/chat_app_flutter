import 'package:flutter/material.dart';

class AppBarSuggestContact extends StatelessWidget implements PreferredSizeWidget {
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
        'Đề xuất kết bạn',
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      actions: [
        // TextButton(
        //   onPressed: () {},
        //   child: ElevatedButton(
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/invite');
        //     },
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: Colors.blue,
        //       foregroundColor: Colors.white,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //     ),
        //     child: Text('Accept Friend Request'),
        //   ),
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
