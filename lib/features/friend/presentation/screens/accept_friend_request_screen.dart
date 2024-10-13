import 'package:flutter/material.dart';
import '../models/user.dart';  // Đảm bảo bạn đã import model User
import '../widgets/friend_card.dart';  // Đảm bảo bạn đã import widget FriendCard

class AcceptFriendRequestScreen extends StatelessWidget {
  final List<User> friendRequests = [
    User(name: 'Lucia', avatarUrl: 'https://example.com/avatar1.jpg', mutualFriends: 50),
    User(name: 'Trí Tuệ', avatarUrl: 'https://example.com/avatar2.jpg', mutualFriends: 30),
    // Bạn có thể thêm nhiều yêu cầu kết bạn khác ở đây
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accept Friend Request"),
      ),
      body: ListView.builder(
        itemCount: friendRequests.length,
        itemBuilder: (context, index) {
          // Truyền tham số isFriendRequest cho FriendCard
          return FriendCard(user: friendRequests[index], isFriendRequest: true);
        },
      ),
    );
  }
}
