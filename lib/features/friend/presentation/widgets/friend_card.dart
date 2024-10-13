import 'package:flutter/material.dart';
import '../models/user.dart';

class FriendCard extends StatelessWidget {
  final User user;
  final bool isFriendRequest;  // Nhận tham số isFriendRequest

  const FriendCard({
    Key? key,
    required this.user,
    required this.isFriendRequest,  // Chắc chắn là tham số được yêu cầu
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
        ),
        title: Text(user.name),
        subtitle: Text('${user.mutualFriends} mutual friends'),
        trailing: isFriendRequest
            ? ElevatedButton(
          onPressed: () {
            // Xử lý hành động chấp nhận kết bạn
          },
          child: Text('Accept'),
        )
            : null,
      ),
    );
  }
}
