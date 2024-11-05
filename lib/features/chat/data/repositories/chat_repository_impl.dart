import 'package:chat_app_flutter/core/common/models/chat.dart';
import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/features/chat/data/sources/chat_remote_data_source.dart';
import 'package:chat_app_flutter/features/chat/data/sources/group_create_data_source.dart';
import 'package:chat_app_flutter/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _chatRemoteDataSource;
  final GroupCreateRemoteDataSource _groupCreateRemoteDataSource;

  ChatRepositoryImpl({
    required ChatRemoteDataSource chatRemoteDataSource,
    required GroupCreateRemoteDataSource groupCreateRemoteDataSource,
  })  : _chatRemoteDataSource = chatRemoteDataSource,
        _groupCreateRemoteDataSource = groupCreateRemoteDataSource;

  @override
  Future<List<Chat>> getAllChats() {
    return _chatRemoteDataSource.getAllChats();
  }

  @override
  Future<Chat> getChat(String chatId) {
    return _chatRemoteDataSource.getChat(chatId);
  }

  @override
  Future<List<Friend>> getAllFriends() {
    return _groupCreateRemoteDataSource.getAllFriends();
  }

  @override
  Future<String> addGroup(
      {required String groupName, required List<User> members}) {
    final memberIds = members.map((user) => user.id!).toList();
    return _groupCreateRemoteDataSource.addGroup(groupName, memberIds);
  }
}
