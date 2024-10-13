import 'package:dio/dio.dart';
import '../../domain/entities/friend.dart';
import '../../domain/repositories/friend_repository.dart';

class FriendRepositoryImpl implements FriendRepository {
  final Dio _dio = Dio();

  @override
  Future<List<Friend>> getFriends() async {
    final response = await _dio.get('https://csvdz6-3000.csb.app/friends'); // URL từ API của bạn
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => Friend(
        id: json['id'],
        name: json['name'],
        avatarUrl: json['avatarUrl'],
      ))
          .toList();
    } else {
      throw Exception('Failed to load friends');
    }
  }

  @override
  Future<void> addFriend(Friend friend) async {
    final response = await _dio.post(
      'https://csvdz6-3000.csb.app/friends', // URL từ API của bạn
      data: {
        'id': friend.id,
        'name': friend.name,
        'avatarUrl': friend.avatarUrl,
      },
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add friend');
    }
  }

  @override
  Future<void> removeFriend(int id) async {
    final response = await _dio.delete('https://csvdz6-3000.csb.app/friends/$id'); // URL từ API của bạn
    if (response.statusCode != 200) {
      throw Exception('Failed to remove friend');
    }
  }
}
