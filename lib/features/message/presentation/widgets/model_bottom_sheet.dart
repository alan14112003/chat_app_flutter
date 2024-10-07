import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_bloc.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModelBottomSheet extends StatelessWidget {
  final Message message;

  const ModelBottomSheet({
    super.key,
    required this.message,
  });

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

  void _showDeleteOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Bạn muốn gỡ tin nhắn này ở phía ai?'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                context.read<MessageBloc>().add(
                      DeleteMessageEvent(
                        message: message,
                      ),
                    );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Chỉ mình tôi'),
                  Icon(Icons.delete),
                ],
              ),
            ),
            if (HandleMessageUtil.isMessageByAuth(
              context,
              message: message,
            ))
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  // Xử lý sự kiện Forward
                  context.read<MessageBloc>().add(
                        RecallMessageEvent(
                          messageId: message.id!,
                        ),
                      );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Đối với mọi người'),
                    Icon(Icons.delete),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
