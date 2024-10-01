import 'package:chat_app_flutter/features/message/presentation/bloc/message_bloc.dart';
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
    // TODO: implement initState
    super.initState();
    context
        .read<MessageBloc>()
        .add(FetchAllMessagesEvent(chatId: widget.chatId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MessageBloc, MessageState>(
        listener: (context, state) {
          if (state is MessageFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is MessageLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MessagesDisplaySuccess) {
            return ListView.builder(
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final blog = state.messages[index];
                return Text(blog.text ?? 'no message');
              },
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<MessageBloc>().add(
                SendMessageEvent(
                  chatId: widget.chatId,
                  content: 'hello 456',
                ),
              );
        },
        tooltip: 'Nhắn tin',
        child: const Icon(Icons.message),
      ),
    );
  }
}
