import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  final String baseUrl = 'https://api.example.com/'; // URL API của bạn

  // Lấy danh sách người dùng từ API
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('${baseUrl}users'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
