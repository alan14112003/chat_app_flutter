import 'package:flutter/material.dart';

class FriendListGroupCreate extends StatefulWidget {
  final List<Map<String, String>> friends;
  // Callback để trả về danh sách bạn bè đã chọn
  final Function(List<Map<String, String>>) onSelectedFriendsChange;

  const FriendListGroupCreate({
    super.key,
    required this.friends,
    required this.onSelectedFriendsChange,
  });

  @override
  _FriendListGroupCreateState createState() => _FriendListGroupCreateState();
}

class _FriendListGroupCreateState extends State<FriendListGroupCreate> {
  late List<bool> _checked;
  // Lưu danh sách bạn bè đã chọn
  List<Map<String, String>> _selectedFriends = [];

  @override
  void initState() {
    super.initState();
    // Khởi tạo danh sách checked cho từng bạn bè
    _checked = List<bool>.filled(widget.friends.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.friends.length,
      itemBuilder: (context, index) {
        // Lấy thông tin bạn bè từ widget.friends
        final friend = widget.friends[index];

        return GestureDetector(
          child: Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: friend['avatar'] != null
                            ? NetworkImage(friend['avatar']!)
                            : null,
                        maxRadius: 30,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                friend['name'] ?? 'No Name',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade500),
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Checkbox(
                  activeColor: Colors.blueAccent,
                  value: _checked[index],
                  onChanged: (bool? value) {
                    setState(() {
                      _checked[index] = value ?? false;

                      if (_checked[index]) {
                        _selectedFriends.add(friend);
                      } else {
                        _selectedFriends
                            .removeWhere((item) => item['id'] == friend['id']);
                      }

                      // Gọi callback để cập nhật danh sách bạn bè đã chọn
                      widget.onSelectedFriendsChange(_selectedFriends);

                      // In ra id và tên của bạn bè được chọn
                      // print('Selected friends:');
                      // for (var selectedFriend in _selectedFriends) {
                      //   print(
                      //       'ID: ${selectedFriend['id']}, Name: ${selectedFriend['name']}');
                      // }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
