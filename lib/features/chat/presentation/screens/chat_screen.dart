import 'package:chat_app_flutter/core/common/widgets/bottom_navigation.dart';
import 'package:chat_app_flutter/core/common/widgets/pop_scope_screen_navigation.dart';
import 'package:chat_app_flutter/core/utils/chat_global_utils.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/chat_view/chat_view_bloc.dart';
import 'package:chat_app_flutter/features/chat/presentation/screens/group_create_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/chat/app_bar_chat.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/chat/chat_user_list.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/chat/search_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => ChatScreen(),
      );

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Lưu giá trị tìm kiếm
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<ChatViewBloc>().add(GetAllChatEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScopeScreenNavigation(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarChat(
            group_button: () {
              Navigator.push(context, GroupCreateScreen.route());
            },
          ),
          body: Column(
            children: [
              SearchBarChat(
                onSearchChanged: (value) {
                  setState(() {
                    // Cập nhật giá trị tìm kiếm
                    searchQuery = value;
                  });
                },
              ),
              Expanded(
                child: BlocBuilder<ChatViewBloc, ChatViewState>(
                  builder: (context, state) {
                    if (state is ChatViewLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ChatViewFailure) {
                      return Center(child: Text('Error: ${state.error}'));
                    } else if (state is ChatViewSuccess) {
                      final filteredChats = state.chats.where((chat) {
                        final chatName = chat.groupName ??
                            ChatGlobalUtils.getChatFriend(chat).fullName;
                        return chatName!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase());
                      }).toList();

                      return ChatUserList(chats: filteredChats);
                    } else {
                      return Center(child: Text('Chưa có đoạn chat'));
                    }
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigation(),
        ),
      ),
    );
  }
}
