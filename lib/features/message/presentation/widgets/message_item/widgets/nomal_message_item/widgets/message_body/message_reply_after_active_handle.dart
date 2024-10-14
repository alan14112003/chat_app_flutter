import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageReplyAfterActiveHandle extends StatefulWidget {
  final Widget child;
  final Message message;

  const MessageReplyAfterActiveHandle({
    super.key,
    required this.message,
    required this.child,
  });

  @override
  State<MessageReplyAfterActiveHandle> createState() =>
      _MessageReplyAfterActiveHandleState();
}

class _MessageReplyAfterActiveHandleState
    extends State<MessageReplyAfterActiveHandle> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<MessageHandleCubit, MessageHandleState, Message?>(
      selector: (state) => state.messageReplyAfterActive,
      builder: (context, messageReplyAfterActive) {
        if (messageReplyAfterActive == null) {
          return widget.child;
        }

        if (messageReplyAfterActive != widget.message) {
          return widget.child;
        }

        Future.delayed(
          Duration(milliseconds: 500),
          () {
            if (context.mounted) {
              print('check');
              context
                  .read<MessageHandleCubit>()
                  .activeMessage(messageReplyAfterActive.id!);
            }
          },
        );

        return Transform.scale(
          scaleX: 1.15,
          child: widget.child,
        );
      },
    );
  }
}
