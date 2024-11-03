
import 'package:chat_app_flutter/core/utils/auth_global_utils.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/event/friend_view_event.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_view_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/state/friend_view_state.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/app_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/list_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/search_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/navigation/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => ContactScreen(),
      );
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int _currentIndex = 1;
  late final String userId;
  // FriendViewHandleEnum friendViewHandleEnum = FriendViewHandleEnum.friends;

  @override
  void initState() {
    super.initState();
    userId = AuthGlobalUtils.getAuth().id ?? '';  
    context.read<FriendViewBloc>().add(LoadFriendsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
          child: AppBarContact(
            onInviteFriend: () {
              Navigator.pushNamed(context, '/invite');
            },
          ),
        ),
      ),
      body: Column(
        children: [
          const SearchBarContact(),
          Expanded(
            child: userId.isEmpty
                ? const Center(child: Text('Người dùng chưa đăng nhập.'))
                : BlocBuilder<FriendViewBloc, FriendViewState>(
              builder: (context, state) {
                if (state is FriendLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FriendLoaded) {
                  final friends = state.friend.where((friend) {
                    return friend.userFrom != friend.userTo;
                  }).map((friend) {
                    final isUserFrom = friend.userFrom == userId;
                    final relevantUser = isUserFrom ? friend.to : friend.from;

                    return {
                      'id': relevantUser?.id ?? '',
                      'name': relevantUser?.fullName ?? '',
                      'avatar': relevantUser?.avatar ?? ''
                    };
                  }).toList();

                  return ListContact(contacts: friends);
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
    );
  }
}
