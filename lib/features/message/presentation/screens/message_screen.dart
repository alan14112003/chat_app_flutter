import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_container.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_input_box/message_input_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageScreen extends StatefulWidget {
  final String chatId;

  static route(String chatId) => MaterialPageRoute(
        builder: (context) => MessageScreen(
          chatId: chatId,
        ),
      );

  const MessageScreen({super.key, required this.chatId});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  _MessageScreenState();

  @override
  void initState() {
    super.initState();

    context.read<MessageHandleCubit>().selectedChat(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          MessageContainer(),
          MessageInputBox(),
        ],
      ),
    );
  }
}
