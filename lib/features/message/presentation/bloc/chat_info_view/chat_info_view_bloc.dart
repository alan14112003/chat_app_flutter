import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/chat.dart';
import 'package:chat_app_flutter/features/chat/domain/usecases/get_chat.dart';
import 'package:equatable/equatable.dart';

part 'chat_info_view_event.dart';
part 'chat_info_view_state.dart';

class ChatInfoViewBloc extends Bloc<ChatInfoViewEvent, ChatInfoViewState> {
  final GetChat _getChat;

  ChatInfoViewBloc({
    required getChat,
  })  : _getChat = getChat,
        super(ChatInfoViewInitial()) {
    on<GetChatEvent>(_onGetChat);
  }

  FutureOr<void> _onGetChat(
    GetChatEvent event,
    Emitter<ChatInfoViewState> emit,
  ) async {
    emit(ChatInfoViewLoading());
    final res = await _getChat.call(GetChatParams(
      chatId: event.chatId,
    ));

    res.fold(
      (failure) => emit(ChatInfoViewFailure(failure.message)),
      (chat) => emit(ChatInfoViewSuccess(chat: chat)),
    );
  }
}
