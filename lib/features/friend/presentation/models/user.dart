class User {
  final String name;
  final String avatarUrl;
  final int mutualFriends;

  User({
    required this.name,
    required this.avatarUrl,
    required this.mutualFriends,
  });

  // Phương thức khởi tạo từ JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      avatarUrl: json['avatar_url'],
      mutualFriends: json['mutual_friends'],
    );
  }
}
