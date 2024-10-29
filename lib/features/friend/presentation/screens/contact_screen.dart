import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_event.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/app_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/list_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/search_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/navigation/bottom_navigation_bar.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/get_friends.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    context.read<FriendBloc>().add(LoadFriendsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
          child: CustomAppBar(
            onInviteFriend: () {
              Navigator.pushNamed(context, '/suggest');
            },
          ),
        ),
      ),
      body: Column(
        children: [
          const SearchBarContact(),
          Expanded(
            child: BlocBuilder<FriendBloc, FriendState>(
              builder: (context, state) {
                if (state is FriendLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FriendLoaded) {
                  final friends = state.users
                      .map((friend) => {'name': friend.fullName, 'avatar': friend.avatar})
                      .toList();
                  return ContactList(contacts: friends);
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
