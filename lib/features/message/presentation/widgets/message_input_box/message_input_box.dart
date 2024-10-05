import 'package:chat_app_flutter/core/theme/app_theme.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_input_box.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_input_box/widgets/message_reply_box.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_input_box/widgets/send_file_button.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_input_box/widgets/send_image_button.dart';
import 'package:flutter/material.dart';

class MessageInputBox extends StatefulWidget {
  const MessageInputBox({super.key});

  @override
  State<MessageInputBox> createState() => _MessageInputBoxState();
}

class _MessageInputBoxState extends State<MessageInputBox> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Tạo FocusNode
  bool _isInputMessage = false;

  @override
  void initState() {
    super.initState();

    // Thêm listener để theo dõi sự thay đổi
    _controller.addListener(() {
      setState(() {
        _isInputMessage = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MessageReplyBox(inputFocusNode: _focusNode),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 8,
            top: 0,
            bottom: 8,
          ),
          child: Row(
            crossAxisAlignment: _isInputMessage
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.center,
            children: [
              if (!_isInputMessage) ...[
                // nút gửi ảnh
                SendImageButton(),
                const SizedBox(
                    width: 12), // Khoảng cách giữa các icon và TextField
                // nút gửi file
                SendFileButton(),
                const SizedBox(width: 12)
              ], // Khoảng cách giữa icon và TextField
              Expanded(
                // Sử dụng Expanded để TextField chiếm không gian còn lại
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryContainer,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: TextField(
                    controller: _controller, // Gán controller cho TextField
                    decoration: const InputDecoration(
                      hintText: 'nhắn tin',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                    ),
                    minLines: 1,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    focusNode: _focusNode,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SendMessageButton(
                controller: _controller,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
