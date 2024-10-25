import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/chat_info_view/chat_info_view_bloc.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
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
  // TODO: implement preferredSize
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
            leadingWidth: 100,
            leading: Row(
              children: [
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 20,
                  // backgroundImage: NetworkImage(),
                ),
                SizedBox(width: 10),
              ],
            ),
            title: Text(
              state.chat.isGroup == true
                  ? state.chat.groupName!
                  : HandleMessageUtil.getInfoFriend(
                      state.chat.members!,
                    ),
              style: TextStyle(fontSize: 18),
            ),
            centerTitle: false,
          );
        }
        return AppBar();
      },
    );
  }
}
