import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/friend_card.dart';
import 'search_delegate.dart';  // Import CustomSearchDelegate

class ContactsScreen extends StatelessWidget {
  final List<User> friends = [
    User(name: 'Lucia', avatarUrl: 'https://example.com/avatar1.jpg', mutualFriends: 50),
    User(name: 'Trí Tuệ', avatarUrl: 'https://example.com/avatar2.jpg', mutualFriends: 30),
    // Thêm các bạn bè ở đây
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());  // Gọi CustomSearchDelegate để tìm kiếm
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          // Truyền tham số isFriendRequest cho FriendCard
          return FriendCard(user: friends[index], isFriendRequest: false);  // Đảm bảo rằng 'isFriendRequest' được truyền vào
        },
      ),
    );
  }
}
