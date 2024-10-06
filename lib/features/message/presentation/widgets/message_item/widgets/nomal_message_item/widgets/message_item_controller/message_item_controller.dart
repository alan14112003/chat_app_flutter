import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_item_controller/widgets/message_item_by_auth.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_item_controller/widgets/message_item_by_other.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageItemController extends StatefulWidget {
  final Message message;
  final List<Message> messages;
  final int index;

  const MessageItemController({
    super.key,
    required this.message,
    required this.messages,
    required this.index,
  });

  @override
  State<MessageItemController> createState() => _MessageItemControllerState();
}

class _MessageItemControllerState extends State<MessageItemController> {
  Offset _offset = Offset.zero;
  bool _isDragging = false;

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      if (HandleMessageUtil.isMessageByAuth(context, message: widget.message)) {
        if (_offset.dx > 0) {
          return;
        }

        _isDragging = true;
      } else {
        if (_offset.dx < 0) {
          return;
        }

        _isDragging = true;
      }

      // Cập nhật vị trí khi kéo
      _offset = Offset(_offset.dx + details.delta.dx, _offset.dy);
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    // Gọi hàm x khi kết thúc kéo
    if (HandleMessageUtil.isMessageByAuth(context, message: widget.message)) {
      // Tin nhắn của người dùng
      if (_offset.dx < -10) {
        // Kéo qua trái
        HandleMessageUtil.setReplyMessage(
          context,
          message: widget.message,
        );
      }
    } else {
      // Tin nhắn của người khác
      if (_offset.dx > 10) {
        // Kéo qua phải
        HandleMessageUtil.setReplyMessage(
          context,
          message: widget.message,
        );
      }
    }

    setState(() {
      _offset = Offset.zero; // Quay lại vị trí ban đầu khi thả
      _isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MessageHandleCubit>().activeMessage(widget.message.id!);
      },
      onLongPress: () {
        HandleMessageUtil.showMessageOptions(
          context,
          message: widget.message,
        );
      },
      onPanUpdate: _handleDragUpdate,
      onPanEnd: _handleDragEnd,
      child: Transform.translate(
        offset: _offset, // Áp dụng offset cho vị trí
        child: HandleMessageUtil.isMessageByAuth(
          context,
          message: widget.message,
        )
            ? MessageItemByAuth(
                message: widget.message,
                isDragging: _isDragging,
              )
            : MessageItemByOther(
                isDragging: _isDragging,
                messages: widget.messages,
                message: widget.message,
                index: widget.index,
              ),
      ),
    );
  }
}
