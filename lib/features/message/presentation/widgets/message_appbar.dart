import 'package:chat_app_flutter/core/utils/chat_global_utils.dart';
import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/chat/presentation/screens/chat_screen.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/chat_info_view/chat_info_view_bloc.dart';
import 'package:chat_app_flutter/features/video_call/presentation/bloc/video_call_user_handle/video_call_user_handle_bloc.dart';
import 'package:chat_app_flutter/features/video_call/presentation/screen/video_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String chatId;
  const MessageAppbar({
    super.key,
    required this.chatId,
  });

  @override
  State<MessageAppbar> createState() => _MessageAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MessageAppbarState extends State<MessageAppbar> {
  @override
  void initState() {
    super.initState();
    context.read<ChatInfoViewBloc>().add(GetChatEvent(chatId: widget.chatId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatInfoViewBloc, ChatInfoViewState>(
      listener: (context, state) {
        if (state is ChatInfoViewFailure) {
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is ChatInfoViewSuccess) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.0,
                ),
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              leadingWidth: 90,
              leading: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacement(context, ChatScreen.route());
                    },
                  ),
                  Expanded(
                    child: ChatGlobalUtils.isGroupChat(state.chat)
                        ? CircleAvatar(
                            child: Text(
                              ChatGlobalUtils.getNameAvatarGroupChat(
                                state.chat,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(
                              ChatGlobalUtils.getChatFriend(
                                    state.chat,
                                  ).avatar ??
                                  '',
                            ),
                          ),
                  ),
                ],
              ),
              title: Text(
                state.chat.isGroup == true
                    ? state.chat.groupName!
                    : ChatGlobalUtils.getChatFriend(
                        state.chat,
                      ).fullName!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: false,
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent, // Loại bỏ hiệu ứng bóng
                    elevation: 0, // Loại bỏ độ nổi
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    context
                        .read<VideoCallUserHandleBloc>()
                        .add(JoinVideoCallEvent(chatId: widget.chatId));
                    Navigator.push(
                      context,
                      VideoCallScreen.route(widget.chatId),
                    );
                  },
                  child: Icon(
                    Icons.video_call_rounded,
                    size: 32,
                  ),
                )
              ],
            ),
          );
        }
        return AppBar();
      },
    );
  }
}
