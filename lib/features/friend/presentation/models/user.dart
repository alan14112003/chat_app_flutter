class User {
  final String id;
  final String fullName;
  final String avatar;

  User({
    required this.id,
    required this.fullName,
    required this.avatar,
  });

  // Phương thức khởi tạo từ JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      avatar: json['avatar'] as String,
    );
  }
}
