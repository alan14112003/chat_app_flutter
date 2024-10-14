import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_body/message_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageReplyController extends StatefulWidget {
  final Message message;
  final MessageBodyType type;
  final Widget child;

  const MessageReplyController({
    super.key,
    required this.message,
    required this.type,
    required this.child,
  });

  @override
  State<MessageReplyController> createState() => _MessageReplyControllerState();
}

class _MessageReplyControllerState extends State<MessageReplyController> {
  @override
  Widget build(BuildContext context) {
    return widget.type == MessageBodyType.normal
        ? Container(
            child: widget.child,
          )
        : GestureDetector(
            onTap: () {
              context
                  .read<MessageHandleCubit>()
                  .toggleMessageReplyActive(widget.message);
            },
            child: widget.child,
          );
  }
}
