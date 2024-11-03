
import 'package:chat_app_flutter/features/friend/presentation/bloc/event/friend_view_event.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_view_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/state/friend_view_state.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/invite/app_bar_invite_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/invite/search_bar_invite_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/invite/user_list_invite.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/navigation/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  _InviteScreenState createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    context.read<FriendViewBloc>().add(LoadInviteFriendsEvent());
  }


  void _goBack(BuildContext context) {
    context.read<FriendViewBloc>().add(LoadFriendsEvent());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _goBack(context);
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Container(
            padding: const EdgeInsets.only(top: 22.0, bottom: 6.0),
            child: AppBarInviteContact(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => _goBack(context),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            const SearchBarInviteContact(),
            Expanded(
              child: BlocBuilder<FriendViewBloc, FriendViewState>(
                builder: (context, state) {
                  if (state is FriendLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FriendLoaded) {
                    final friends = state.friend
                        .map((friend) => {
                      'id': friend.userFrom ?? '',
                      'name': friend.from?.fullName ?? '',
                      'avatar': friend.from?.avatar ?? ''
                    })
                        .toList();
                    return UserListInvite(inviteFriends: friends);
                  } else if (state is FriendError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('Chưa kết bạn'));
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              if (_currentIndex == 0) {
                Navigator.pushReplacementNamed(context, '/chats');
              } else if (_currentIndex == 1) {
                Navigator.pushReplacementNamed(context, '/contacts');
              } else if (_currentIndex == 2) {
                Navigator.pushReplacementNamed(context, '/settings');
              }
            });
          },
        ),
      ),
    );
  }
}