import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageContainer extends StatefulWidget {
  const MessageContainer({super.key});

  @override
  State<MessageContainer> createState() => _MessageContainerState();
}

class _MessageContainerState extends State<MessageContainer> {
  @override
  void initState() {
    super.initState();

    // Sử dụng context.select để lấy chatId từ MessageHandleCubit
    final chatId = context.read<MessageHandleCubit>().state.chatId;

    // Gửi sự kiện để fetch messages từ MessageBloc
    context.read<MessageBloc>().add(FetchAllMessagesEvent(chatId: chatId));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<MessageBloc, MessageState>(
          listener: (context, state) {
            if (state is MessageFailure) {
              showSnackBar(context, state.error);
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
                reverse: true,
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  return MessageItem(
                    message: state.messages[index],
                    messages: state.messages,
                    index: index,
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
