import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/chat.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/chat/domain/usecases/get_all_chat.dart';
import 'package:equatable/equatable.dart';

part 'chat_view_event.dart';
part 'chat_view_state.dart';

class ChatViewBloc extends Bloc<ChatViewEvent, ChatViewState> {
  final GetAllChat _getAllChat;
  // final String currentUserId; // ID người dùng hiện tại

  ChatViewBloc({
    required getAllChat,
    // required this.currentUserId,
  })  : _getAllChat = getAllChat,
        super(ChatViewInitial()) {
    on<GetAllChatEvent>(_onGetAllChat);
  }

  Future<void> _onGetAllChat(
      GetAllChatEvent event, Emitter<ChatViewState> emit) async {
    emit(ChatViewLoading());
    final result = await _getAllChat(NoParams());
    print('Result: $result');

    result.fold(
      (failure) => emit(ChatViewFailure(failure.message)),
      (chat) => emit(ChatViewSuccess(chats: chat)),
    );
  }
}
