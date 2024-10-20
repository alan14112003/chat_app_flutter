import 'package:chat_app_flutter/core/common/models/chat.dart';
import 'package:chat_app_flutter/features/chat/data/sources/chat_remote_data_source.dart';
import 'package:chat_app_flutter/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _chatRemoteDataSource;

  ChatRepositoryImpl({
    required ChatRemoteDataSource chatRemoteDataSource,
  }) : _chatRemoteDataSource = chatRemoteDataSource;

  @override
  Future<List<Chat>> getAllChats() {
    return _chatRemoteDataSource.getAllChats();
  }
}
