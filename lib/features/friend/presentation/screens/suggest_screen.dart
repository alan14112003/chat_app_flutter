// import 'package:flutter/material.dart';
// import '../models/user.dart';
// import '../widgets/friend_card.dart';

// class SuggestScreen extends StatefulWidget {
//   @override
//   _SuggestScreenState createState() => _SuggestScreenState();
// }

// class _SuggestScreenState extends State<SuggestScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<User> suggestedUsers = [
//     User(name: 'Lê Thị Dân Liên', avatarUrl: 'https://example.com/avatar1.jpg', mutualFriends: 266),
//     User(name: 'Tô Uyên', avatarUrl: 'https://example.com/avatar2.jpg', mutualFriends: 150),
//     User(name: 'Cindy', avatarUrl: 'https://example.com/avatar3.jpg', mutualFriends: 100),
//     // Dữ liệu gợi ý
//   ];

//   List<User> filteredUsers = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredUsers = suggestedUsers;
//   }

//   void _filterSuggestions(String query) {
//     setState(() {
//       filteredUsers = suggestedUsers
//           .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Suggest"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: CustomSearchDelegate(),
//               );
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: filteredUsers.length,
//         itemBuilder: (context, index) {
//           return FriendCard(user: filteredUsers[index]);
//         },
//       ),
//     );
//   }
// }
