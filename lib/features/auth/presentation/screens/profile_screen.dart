import 'package:chat_app_flutter/core/common/cubit/app_auth/app_auth_cubit.dart';
import 'package:chat_app_flutter/core/utils/auth_global_utils.dart';
import 'package:chat_app_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      );

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AppAuthCubit>();
    final currentUser = AuthGlobalUtils.getAuth();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tài khoản cá nhân'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authCubit.logout();
              Navigator.push(context, LoginScreen.route());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            CircleAvatar(
              backgroundImage: NetworkImage(currentUser.avatar!),
              maxRadius: 50,
            ),
            SizedBox(height: 20),
            Text(
              currentUser.fullName!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'Họ và tên:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller:
                          TextEditingController(text: currentUser.fullName!),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'Email:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: TextField(
                      controller:
                          TextEditingController(text: currentUser.email!),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Cập nhật'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
