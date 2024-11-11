import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/core/common/models/user_with_friend.dart';
import 'package:dio/dio.dart';

class FriendRemoteDataSource {
  final Dio _dio;

  FriendRemoteDataSource({required Dio dio}) : _dio = dio;

  Future<List<Friend>> allFriends() async {
    final Response<List<dynamic>> response = await _dio.get('/friends');
    return response.data!.map<Friend>((friendJson) {
      return Friend.fromJson(friendJson as Map<String, dynamic>);
    }).toList();
  }

  Future<List<Friend>> requestFriends() async {
    final Response<List<dynamic>> response =
        await _dio.get('/friends/requests');

    return response.data!.map<Friend>((friendJson) {
      return Friend.fromJson(friendJson as Map<String, dynamic>);
    }).toList();
  }

  Future<void> addFriendById(String friendId) async {
    final data = {
      "userTo": friendId,
    };

    await _dio.post('/friends/add', data: data);
  }

  Future<void> acceptFriendById(String friendId) async {
    final data = {
      "userFrom": friendId,
    };

    await _dio.post('/friends/accept', data: data);
  }

  Future<void> removeFriendById(String friendId) async {
    final data = {
      "userTo": friendId,
    };

    await _dio.post('/friends/remove', data: data);
  }

  Future<UserWithFriend?> findFriendByEmail(String email) async {
    final response = await _dio.get('/users', queryParameters: {'key': email});
    final data = response.data as List<dynamic>;

    if (data.isEmpty) {
      return null;
    }

    return UserWithFriend.fromJson(response.data[0]);
  }
}
