import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/chat.dart';
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
    on<ReloadAllChatEvent>(_onReloadAllChat);
  }

  Future<void> _onGetAllChat(
      GetAllChatEvent event, Emitter<ChatViewState> emit) async {
    emit(ChatViewLoading());
    final result = await _getAllChat(NoParams());

    result.fold(
      (failure) => emit(ChatViewFailure(failure.message)),
      (chat) => emit(ChatViewSuccess(chats: chat)),
    );
  }

  Future<void> _onReloadAllChat(
    ReloadAllChatEvent event,
    Emitter<ChatViewState> emit,
  ) async {
    final result = await _getAllChat(NoParams());

    result.fold(
      (failure) => emit(ChatViewFailure(failure.message)),
      (chats) => emit(ChatViewSuccess(chats: chats)),
    );
  }
}
