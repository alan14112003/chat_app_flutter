import 'package:chat_app_flutter/core/common/widgets/bottom_navigation.dart';
import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_view/friend_view_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/screens/invite_screen.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/app_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/list_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/search_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/utils/handle_friend_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => ContactScreen(),
      );

  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FriendViewBloc>().add(LoadAllFriendsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          padding: const EdgeInsets.only(
            top: 16.0,
            bottom: 6.0,
          ),
          child: AppBarContact(
            onInviteFriend: () {
              Navigator.push(context, InviteScreen.route());
            },
          ),
        ),
      ),
      body: Column(
        children: [
          const SearchBarContact(),
          Expanded(
            child: BlocConsumer<FriendViewBloc, FriendViewState>(
              listener: (context, state) {
                if (state is FriendViewError) {
                  showSnackBar(context, state.message);
                  return;
                }
              },
              builder: (context, state) {
                if (state is FriendViewLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FriendViewSuccess) {
                  final friends = state.friends.where((friend) {
                    return friend.userFrom != friend.userTo;
                  }).map((friend) {
                    final friendUser = HandleFriendUtils.getInfoFriend(friend);

                    return {
                      'id': friendUser.id ?? '',
                      'name': friendUser.fullName ?? '',
                      'avatar': friendUser.avatar ?? ''
                    };
                  }).toList();

                  return ListContact(contacts: friends);
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
