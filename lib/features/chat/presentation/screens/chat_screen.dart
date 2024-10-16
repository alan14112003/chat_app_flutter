import 'package:chat_app_flutter/features/chat/presentation/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueAccent, child: Center(child: Text('chat screen'),)),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}