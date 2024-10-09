import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_bottom_sheet/message_delete_dialog.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:flutter/material.dart';

class MessageBottomSheet extends StatelessWidget {
  final Message message;

  const MessageBottomSheet({
    super.key,
    required this.message,
  });

  void _showDeleteOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MessageDeleteDialog(
          message: message,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceAround, // Sắp xếp các mục đều nhau
        children: [
          GestureDetector(
            onTap: () {
              // Xử lý hành động trả lời
              HandleMessageUtil.setReplyMessage(
                context,
                message: message,
              );

              Navigator.pop(context); // Đóng hộp thoại
            },
            child: const Column(
              children: [
                Icon(Icons.reply),
                SizedBox(height: 8),
                Text('Phản hồi'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Xử lý hành động sao chép
              Navigator.pop(context); // Đóng hộp thoại
            },
            child: const Column(
              children: [
                Icon(Icons.copy),
                SizedBox(height: 8),
                Text('Sao chép'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Xử lý hành động xóa
              Navigator.pop(context); // Đóng hộp thoại
              _showDeleteOptions(context);
            },
            child: const Column(
              children: [
                Icon(Icons.delete),
                SizedBox(height: 8),
                Text('Xóa'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
