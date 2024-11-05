import 'package:chat_app_flutter/core/utils/chat_global_utils.dart';
import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/chat_info_view/chat_info_view_bloc.dart';
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
          return AppBar(
            leadingWidth: 90,
            leading: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: (state.chat.isGroup == false)
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            ChatGlobalUtils.getChatFriend(
                                  state.chat,
                                ).avatar ??
                                '',
                          ),
                        )
                      : CircleAvatar(
                          child: Text(state.chat.members!
                              .map((member) => member.firstName![0])
                              .join()
                              .toUpperCase()),
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
          );
        }
        return AppBar();
      },
    );
  }
}
