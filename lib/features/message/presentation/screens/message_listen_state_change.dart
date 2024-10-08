import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_view/message_view_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_system_handle/message_system_handle_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_user_handle/message_user_handle_bloc.dart';

class MessageListenStateChange extends StatefulWidget {
  final Widget child;

  const MessageListenStateChange({
    super.key,
    required this.child,
  });

  @override
  State<MessageListenStateChange> createState() =>
      _MessageListenStateChangeState();
}

class _MessageListenStateChangeState extends State<MessageListenStateChange> {
  void _listenMessageUserHandleStateChange(
    BuildContext context,
    MessageUserHandleState state,
  ) {
    // xử lý khi hành động thất bại
    if (state is MessageUserHandleFailure) {
      showSnackBar(context, state.error);
      return;
    }

    // gửi tin nhắn thành công
    if (state is SendMessageSuccess) {
      context.read<MessageViewBloc>().add(
            ReRenderMessagesEvent(messsages: state.messages),
          );
      return;
    }

    // xóa tin nhắn thành công
    if (state is DeleteMessageSuccess) {
      context.read<MessageViewBloc>().add(
            FetchAllMessagesEvent(
              chatId: state.message.chatId!,
              isNew: false,
            ),
          );
      return;
    }

    // thu hồi tin nhắn thành công
    if (state is RecallMessageSuccess) {
      context.read<MessageViewBloc>().add(
            FetchAllMessagesEvent(
              chatId: state.message.chatId!,
              isNew: false,
            ),
          );
      return;
    }
  }

  void _listenMessageSystemHandleStateChange(
    BuildContext context,
    MessageSystemHandleState state,
  ) {
    // xử lý khi hành động của hệ thống thất bại
    if (state is MessageSystemHandleFailure) {
      showSnackBar(context, state.error);
      return;
    }

    // nhận tin nhắn mới thành công
    if (state is ReceiveNewMessageSuccess) {
      context.read<MessageViewBloc>().add(
            ReRenderMessagesEvent(messsages: state.messages),
          );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MessageUserHandleBloc, MessageUserHandleState>(
          listener: _listenMessageUserHandleStateChange,
        ),
        BlocListener<MessageSystemHandleBloc, MessageSystemHandleState>(
          listener: _listenMessageSystemHandleStateChange,
        ),
      ],
      child: widget.child,
    );
  }
}
