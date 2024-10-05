import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/theme/app_theme.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class MessageReplyBox extends StatefulWidget {
  final FocusNode inputFocusNode;

  const MessageReplyBox({
    super.key,
    required this.inputFocusNode,
  });

  @override
  State<MessageReplyBox> createState() => _MessageReplyBoxState();
}

class _MessageReplyBoxState extends State<MessageReplyBox> {
  Message? messageReplyPre;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: BlocSelector<MessageHandleCubit, MessageHandleState, Message?>(
        selector: (state) => state.messageReply,
        builder: (context, messageReply) {
          if (messageReply == null) {
            return Container();
          }

          final bool isKeyboardVisible =
              KeyboardVisibilityProvider.isKeyboardVisible(context);
          // thực hiện focus vào input
          if (!isKeyboardVisible) {
            widget.inputFocusNode.unfocus();
          }

          if (messageReplyPre != messageReply) {
            Future.delayed(
              const Duration(milliseconds: 100),
              () {
                widget.inputFocusNode.requestFocus();
              },
            );
          }

          messageReplyPre = messageReply;

          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide()),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trả lời ${messageReply.sender?.firstName}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8),
                        child: Text(messageReply.text ?? ''))
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: Theme.of(context).secondarySurface,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: GestureDetector(
                    onTap: () {
                      context.read<MessageHandleCubit>().setMessageReply(null);
                      messageReplyPre = null;
                    },
                    child: const Icon(Icons.close_sharp),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
