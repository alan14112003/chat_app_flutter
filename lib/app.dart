import 'package:chat_app_flutter/core/dependencies/init_dependencies.dart';
import 'package:chat_app_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/screens/chat_screen.dart';
import 'package:chat_app_flutter/features/friend/presentation/screens/contact_screen.dart';
import 'package:chat_app_flutter/features/friend/presentation/screens/invite_screen.dart';
import 'package:chat_app_flutter/features/message/presentation/screens/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Socket _socket = serviceLocator<Socket>();
  @override
  void initState() {
    super.initState();

    // connect socket
    _socket.onConnect((_) {
      print('connect');
      _socket.emit('join', '4867a4a8-0a22-4af0-a15c-9d83a48e05b4');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat app',
      theme: ThemeData(
        useMaterial3: true,
      ),
      // mặc định phải để cái này để khỏi xung đột
      // home: const MessageScreen(
      //   chatId: '3bf8c507-8ef0-4931-ac15-92672195cb20',
      // ),
      // home: ChatScreen(),
      // home: LoginScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => ContactScreen(),
        '/suggest': (context) => SuggestScreen()
      },
    );
  }
}
