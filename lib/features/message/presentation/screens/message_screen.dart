import 'package:chat_app_flutter/core/dependencies/init_dependencies.dart';
import 'package:chat_app_flutter/features/message/events/handle_message_event.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/screens/message_listen_state_change.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_appbar.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_container.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_input_box/message_input_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

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
  final HandleMessageEvent _messageEvent = HandleMessageEvent(
    socket: serviceLocator<Socket>(),
  );

  _MessageScreenState();

  @override
  void initState() {
    super.initState();

    context.read<MessageHandleCubit>().selectedChat(widget.chatId);
    _messageEvent.onReceiveNewMessage(context);
    _messageEvent.onReceivePinMessage(context);
    _messageEvent.onReceiveRecallMessage(context);
  }

  @override
  void dispose() {
    super.dispose();

    _messageEvent.offReceiveNewMessage(context);
    _messageEvent.offReceivePinMessage(context);
    _messageEvent.offReceiveRecallMessage(context);
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
