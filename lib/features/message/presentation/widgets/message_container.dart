import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_view/message_view_bloc.dart';
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
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // khởi tạo scroll controller
    _scrollController = ScrollController();

    // lắng nghe sự kiện scroll
    _scrollController.addListener(_onScroll);

    // Sử dụng context.select để lấy chatId từ MessageHandleCubit
    final chatId = context.read<MessageHandleCubit>().state.chatId;

    // Gửi sự kiện để fetch messages từ MessageViewBloc
    context.read<MessageViewBloc>().add(FetchAllMessagesEvent(chatId: chatId));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onScroll() {
    // kiểm tra xem đã kéo đến cuối chưa
    bool isAtTop = _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;

    if (!isAtTop) {
      return;
    }

    final messageState = context.read<MessageViewBloc>().state;
    if (messageState is! MessagesDisplaySuccess) {
      return;
    }

    final message = messageState.messages.last;
    final chatId = context.read<MessageHandleCubit>().state.chatId;

    context.read<MessageViewBloc>().add(
          FetchAllMessagesEvent(
            chatId: chatId,
            before: message.id,
            isNew: false,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<MessageViewBloc, MessageViewState>(
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
                controller: _scrollController,
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
