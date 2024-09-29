import 'package:chat_app_flutter/features/message/presentation/screens/message_screen.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat app',
      theme: ThemeData(
        useMaterial3: true,
      ),
      // mặc định phải để cái này để khỏi xung đột
      home: const MessageScreen(
        chatId: '3bf8c507-8ef0-4931-ac15-92672195cb20',
      ),
    );
  }
}
