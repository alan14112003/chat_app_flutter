import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/screens/message_listen_state_change.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_appbar.dart';
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
  void deactivate() {
    context.read<MessageHandleCubit>().clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MessageAppbar(chatId: widget.chatId),
        body: MessageListenStateChange(
          child: const Column(
            children: [
              MessageContainer(),
              MessageInputBox(),
            ],
          ),
        ),
      ),
    );
  }
}
