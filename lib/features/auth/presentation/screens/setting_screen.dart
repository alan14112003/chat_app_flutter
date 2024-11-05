import 'package:chat_app_flutter/core/common/cubit/app_auth/app_auth_cubit.dart';
import 'package:chat_app_flutter/core/common/widgets/bottom_navigation.dart';
import 'package:chat_app_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => SettingScreen(),
      );

  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AppAuthCubit>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authCubit.logout();
              if (context.mounted) {
                Navigator.push(context, LoginScreen.route());
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Text('User Profile Information'),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
