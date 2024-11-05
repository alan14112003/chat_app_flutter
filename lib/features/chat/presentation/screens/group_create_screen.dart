import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/utils/auth_global_utils.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/add_group/add_group_bloc.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/group_create_view/group_create_view_bloc.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/group_create.dart/app_bar_group_create.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/group_create.dart/search_group_create.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/group_create.dart/friend_list_group_create.dart';
import 'package:chat_app_flutter/features/message/presentation/screens/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupCreateScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => GroupCreateScreen(),
      );

  const GroupCreateScreen({super.key});

  @override
  State<GroupCreateScreen> createState() => _GroupCreateScreenState();
}

class _GroupCreateScreenState extends State<GroupCreateScreen> {
  late final String userId;
  String groupName = '';
  // Lưu danh sách bạn bè đã chọn
  List<Map<String, String>> _selectedFriends = [];
  // Lưu giá trị tìm kiếm
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    userId = AuthGlobalUtils.getAuth().id ?? '';
    context.read<GroupCreateViewBloc>().add(GetAllFiendEvent());
  }

  void _createGroup() {
    if (groupName.isNotEmpty && _selectedFriends.length >= 2) {
      // print('Group Name: $groupName');
      // print('In ra danh sách bạn bè được chọn:');

      // for (var friend in _selectedFriends) {
      //   print('ID: ${friend['id']}, Name: ${friend['name']}');
      // }

      context.read<AddGroupBloc>().add(AddGroupRequested(
          groupName: groupName,
          members: _selectedFriends.map((friend) {
            return User(id: friend['id'], fullName: friend['name']);
          }).toList()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Vui lòng nhập tên nhóm và chọn ít nhất 2 thành viên.'),
      ));
    }
  }

  // Hàm lọc bạn bè dựa trên giá trị tìm kiếm
  List<Map<String, String>> _filterFriends(List<Map<String, String>> friends) {
    if (searchQuery.isEmpty) {
      // Trả về toàn bộ danh sách nếu không có giá trị tìm kiếm
      return friends;
    }
    return friends
        .where((friend) =>
            friend['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarGroupCreate(
          group_create_button: _createGroup,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Nhập tên nhóm',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding: EdgeInsets.all(8.0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      // Cập nhật tên nhóm
                      groupName = value;
                    });
                  },
                ),
              ),
              // Cập nhật để truyền hàm tìm kiếm vào SearchBarGroupCreate
              SearchBarGroupCreate(
                onSearchChanged: (value) {
                  setState(() {
                    // Cập nhật giá trị tìm kiếm
                    searchQuery = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gợi ý',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocListener<AddGroupBloc, AddGroupState>(
                  listener: (context, state) {
                    if (state is AddGroupLoading) {
                    } else if (state is AddGroupSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Tạo nhóm thành công'),
                      ));
                      Navigator.push(
                        context,
                        MessageScreen.route(state.chatId),
                      );
                    } else if (state is AddGroupFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Đã xảy ra lỗi khi tạo nhóm: ${state.error}'),
                      ));
                    }
                  },
                  child: BlocBuilder<GroupCreateViewBloc, GroupCreateViewState>(
                    builder: (context, state) {
                      if (state is GroupCreateViewLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is GroupCreateViewFailure) {
                        return Center(child: Text('Error: ${state.error}'));
                      } else if (state is GroupCreateViewSuccess) {
                        final filteredFriends = state.friends.where((friends) {
                          return friends.userFrom != friends.userTo;
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

                        // Lọc bạn bè dựa trên giá trị tìm kiếm
                        final visibleFriends = _filterFriends(filteredFriends);

                        return FriendListGroupCreate(
                          // Hiển thị bạn bè đã lọc
                          friends: visibleFriends,
                          onSelectedFriendsChange: (selectedFriends) {
                            setState(() {
                              _selectedFriends = selectedFriends;
                            });
                          },
                        );
                      } else {
                        return Center(child: Text('Chưa có bạn bè'));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
