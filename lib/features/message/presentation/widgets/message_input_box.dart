import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/theme/app_theme.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class MessageInputBox extends StatefulWidget {
  const MessageInputBox({super.key});

  @override
  State<MessageInputBox> createState() => _MessageInputBoxState();
}

class _MessageInputBoxState extends State<MessageInputBox> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Tạo FocusNode
  bool _isInputMessage = false;
  Message? messageReplyPre;

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
        KeyboardVisibilityProvider(
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
                _focusNode.unfocus();
              }

              if (messageReplyPre != messageReply) {
                Future.delayed(
                  const Duration(milliseconds: 100),
                  () {
                    _focusNode.requestFocus();
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
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.8),
                            child: Text(messageReply.text ?? ''))
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        color: Theme.of(context).secondarySurface,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<MessageHandleCubit>()
                              .setMessageReply(null);
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
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 8,
            top: 12,
            bottom: 8,
          ),
          child: Row(
            crossAxisAlignment: _isInputMessage
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.center,
            children: [
              if (!_isInputMessage) ...[
                GestureDetector(
                  onTap: () {
                    // Xử lý khi nhấn vào icon ảnh
                    print("Image icon tapped");
                  },
                  child: const Icon(
                    Icons.image_outlined,
                    size: 30,
                  ),
                ),
                const SizedBox(
                    width: 12), // Khoảng cách giữa các icon và TextField
                GestureDetector(
                  onTap: () {
                    // Xử lý khi nhấn vào icon file
                    print("File icon tapped");
                  },
                  child: const Icon(
                    Icons.file_present_outlined,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12)
              ], // Khoảng cách giữa icon và TextField
              Expanded(
                // Sử dụng Expanded để TextField chiếm không gian còn lại
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryContainer,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: TextField(
                    controller: _controller, // Gán controller cho TextField
                    decoration: const InputDecoration(
                      hintText: 'nhắn tin',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                    minLines: 1,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 20,
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

class SendMessageButton extends StatelessWidget {
  final TextEditingController controller;
  const SendMessageButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    Message? messageReply = context.select(
      (MessageHandleCubit messageHandleCubit) =>
          messageHandleCubit.state.messageReply,
    );

    String? chatId = context.select(
      (MessageHandleCubit messageHandleCubit) =>
          messageHandleCubit.state.chatId,
    );

    return IconButton(
      icon: const Icon(
        Icons.send,
        size: 24,
      ),
      onPressed: () {
        String content = controller.text.trim();
        if (content == '') {
          return;
        }
        context.read<MessageBloc>().add(
              SendMessageEvent(
                chatId: chatId!,
                content: content,
                replyId: messageReply?.id,
              ),
            );
        // làm sạch input
        if (messageReply != null) {
          context.read<MessageHandleCubit>().setMessageReply(null);
        }
        controller.clear();
      }, // Gọi hàm gửi khi nhấn nút gửi
    );
  }
}
