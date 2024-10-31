
import 'package:chat_app_flutter/features/friend/domain/entities/friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/models/user.dart';
import 'package:dio/dio.dart';

class FriendRemoteDataSource {
  final Dio _dio;

  FriendRemoteDataSource({required Dio dio}) : _dio = dio;

  Future<List<User>> getFriends() async {
    final Response<List<dynamic>> response = await _dio.get('/friends');
    return response.data!.map<User>((friendJson) {
      final fromData = friendJson['from'] as Map<String, dynamic>;
      return User.fromJson(fromData);
    }).toList();
  }
}
