import 'package:chat_app_flutter/core/theme/app_theme.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_input_box/widgets/message_reply_box.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_input_box/widgets/send_image_button.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_input_box/widgets/send_message_button.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_input_box/widgets/speech_to_text_button.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_input_box/widgets/type_content_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    _controller.dispose();
  }

  String ensureGeminiPrefix(String input, {bool remove = false}) {
    const geminiPrefix = '@gemini-ai:';
    final hasGeminiPrefix = input.startsWith(geminiPrefix);

    if (remove) {
      // Nếu cần xóa @gemini, kiểm tra và xóa nó
      return hasGeminiPrefix
          ? input.substring(geminiPrefix.length).trim()
          : input;
    }
    // Nếu cần thêm @gemini, kiểm tra và thêm nó
    return hasGeminiPrefix ? input : '$geminiPrefix $input';
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
              ...[
                SpeechToTextButton(
                  controller: _controller,
                ),
                const SizedBox(width: 12),
                // nút gửi ảnh
                SendImageButton(),
                const SizedBox(width: 12),
                // nút gửi file
                TypeContentButton(),
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
                  child: BlocListener<MessageHandleCubit, MessageHandleState>(
                    listener: (context, state) {
                      if (state.isChatBotContent) {
                        _controller.text = ensureGeminiPrefix(_controller.text);
                        return;
                      }
                      _controller.text = ensureGeminiPrefix(
                        _controller.text,
                        remove: true,
                      );
                    },
                    child: TextField(
                      controller: _controller, // Gán controller cho TextField
                      decoration: const InputDecoration(
                        hintText: 'Nhắn tin',
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
