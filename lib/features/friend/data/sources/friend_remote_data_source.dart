import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/core/common/models/user_with_friend.dart';
import 'package:dio/dio.dart';

class FriendRemoteDataSource {
  final Dio _dio;

  FriendRemoteDataSource({required Dio dio}) : _dio = dio;

  Future<List<Friend>> getFriends() async {
    final Response<List<dynamic>> response = await _dio.get('/friends');
    return response.data!.map<Friend>((friendJson) {
      return Friend.fromJson(friendJson as Map<String, dynamic>);
    }).toList();
  }

  Future<List<Friend>> getInviteFriends() async {
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
    try {
      await _dio.post('/friends/add', data: data);
    } on DioError catch (dioError) {
      final errorMessage =
          dioError.response?.data['message'] ?? "Lỗi mạng hoặc máy chủ";
      throw Exception("Lỗi dio return: $errorMessage");
    } catch (e) {
      throw Exception("Lỗi xử lý return: $e");
    }
  }

  Future<void> acceptFriendById(String friendId) async {
    final data = {
      "userFrom": friendId,
    };
    try {
      await _dio.post('/friends/accept', data: data);
    } on DioError catch (dioError) {
      final errorMessage =
          dioError.response?.data['message'] ?? "Lỗi mạng hoặc máy chủ";
      throw Exception("Lỗi dio return: $errorMessage");
    } catch (e) {
      throw Exception("Lỗi xử lý return: $e");
    }
  }

  Future<void> removeFriendById(String friendId) async {
    final data = {
      "userTo": friendId,
    };
    try {
      await _dio.post('/friends/remove', data: data);
    } on DioError catch (dioError) {
      final errorMessage =
          dioError.response?.data['message'] ?? "Lỗi mạng hoặc máy chủ";
      throw Exception("Lỗi dio return: $errorMessage");
    } catch (e) {
      throw Exception("Lỗi xử lý return: $e");
    }
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
