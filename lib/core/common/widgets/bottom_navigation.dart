import 'package:chat_app_flutter/core/common/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:chat_app_flutter/features/auth/presentation/screens/profile_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/screens/chat_screen.dart';
import 'package:chat_app_flutter/features/friend/presentation/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavigationCubit, int>(
      listener: (context, index) {
        switch (index) {
          case 0:
            Navigator.push(context, ChatScreen.route());
            break;
          case 1:
            Navigator.push(context, ContactScreen.route());
            break;
          case 2:
            Navigator.push(context, ProfileScreen.route());
            break;
          default:
        }
      },
      builder: (context, index) {
        // Mặc định là 0
        return BottomNavigationBar(
          currentIndex: index,
          onTap: (index) {
            context.read<BottomNavigationCubit>().changeIndex(index);
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Đoạn chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              label: 'Danh bạ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Cài đặt',
            ),
          ],
        );
      },
    );
  }
}
