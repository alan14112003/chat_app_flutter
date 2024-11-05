import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:dio/dio.dart';

class GroupCreateRemoteDataSource {
  final Dio _dio;

  GroupCreateRemoteDataSource({required Dio dio}) : _dio = dio;

  Future<List<Friend>> getAllFriends() async {
    final Response<List<dynamic>> friends = await _dio.get(
      '/friends',
    );
    return friends.data!
        .map<Friend>((friend) => Friend.fromJson(friend))
        .toList();
  }

  Future<String> addGroup(String groupName, List<String> memberIds) async {
    final data = {
      'groupName': groupName,
      'members': memberIds,
    };

    try {
      final Response response = await _dio.post('/chats/groups', data: data);
      if (response.statusCode != 200) {
        throw Exception('Failed to create group');
      }
      return response.data['id'];
    } catch (e) {
      throw Exception('Error creating group: $e');
    }
  }
}
