import 'dart:convert';

import 'package:chat_app_flutter/features/friend/presentation/bloc/event/friend_event.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/state/friend_state.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/app_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/list_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/search_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/navigation/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int _currentIndex = 1;
  SharedPreferences? _preferences;
  Future<String?>? _userIdFuture;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    context.read<FriendBloc>().add(LoadFriendsEvent());
  }

  Future<void> _initializePreferences() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _userIdFuture = getUserId();
    });
  }

  Future<String?> getUserId() async {
    _preferences ??= await SharedPreferences.getInstance();
    final userJson = _preferences?.getString('authUser');

    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return userMap['user']['id'];
    }

    return null;
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
            child: _userIdFuture == null
                ? const Center(child: CircularProgressIndicator())
                : FutureBuilder<String?>(
                    future: _userIdFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Lỗi: ${snapshot.error}'));
                      }

                      final userId = snapshot.data;
                      if (userId == null) {
                        return const Center(
                            child: Text('Người dùng chưa đăng nhập.'));
                      }

                      return BlocBuilder<FriendBloc, FriendState>(
                        builder: (context, state) {
                          if (state is FriendLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is FriendLoaded) {
                            final friends = state.friend.where((friend) {
                              return friend.userFrom != friend.userTo;
                            }).map((friend) {
                              final isUserFrom = friend.userFrom == userId;
                              final relevantUser =
                                  isUserFrom ? friend.to : friend.from;

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
                      );
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
