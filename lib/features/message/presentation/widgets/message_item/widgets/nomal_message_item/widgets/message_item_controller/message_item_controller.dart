import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/common/models/user_info.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_item_controller/widgets/message_item_by_auth.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_item_controller/widgets/message_item_by_other.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_item_util.dart';
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

  final auth = UserInfo(id: '4867a4a8-0a22-4af0-a15c-9d83a48e05b4');

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      if (widget.message.sender?.id == auth.id) {
        if (_offset.dx > 0) {
          return;
        }
      } else {
        if (_offset.dx < 0) {
          return;
        }
      }

      // Cập nhật vị trí khi kéo
      _offset = Offset(_offset.dx + details.delta.dx, _offset.dy);

      if (_offset.dx != 0) {
        _isDragging = true;
      }
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    // Gọi hàm x khi kết thúc kéo
    if (widget.message.sender?.id == auth.id) {
      // Tin nhắn của người dùng
      if (_offset.dx < -10) {
        // Kéo qua trái
        HandleMessageItemUtil.handleReplyMessage(
          context,
          message: widget.message,
        );
      }
    } else {
      // Tin nhắn của người khác
      if (_offset.dx > 10) {
        // Kéo qua phải
        HandleMessageItemUtil.handleReplyMessage(
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
        HandleMessageItemUtil.showMessageOptions(context);
      },
      onPanUpdate: _handleDragUpdate,
      onPanEnd: _handleDragEnd,
      child: Transform.translate(
        offset: _offset, // Áp dụng offset cho vị trí
        child: (widget.message.sender?.id != auth.id)
            ? MessageItemByOther(
                isDragging: _isDragging,
                messages: widget.messages,
                message: widget.message,
                index: widget.index,
              )
            : MessageItemByAuth(
                message: widget.message,
                isDragging: _isDragging,
              ),
      ),
    );
  }
}
