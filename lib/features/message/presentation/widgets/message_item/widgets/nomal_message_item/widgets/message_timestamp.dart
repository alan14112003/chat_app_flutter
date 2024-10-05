import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/utils/format_time_difference.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageTimestamp extends StatefulWidget {
  final Message message;
  const MessageTimestamp({
    super.key,
    required this.message,
  });

  @override
  State<MessageTimestamp> createState() => _MessageTimestampState();
}

class _MessageTimestampState extends State<MessageTimestamp> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<MessageHandleCubit, MessageHandleState, int?>(
      selector: (state) => state.messageActive,
      builder: (context, messageActive) {
        if (messageActive == widget.message.id) {
          return Center(
            child: Text(formatTimeDifference(widget.message.createdAt!)),
          );
        }

        return Container();
      },
    );
  }
}
