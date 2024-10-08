import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/get_all_messages.dart';
import 'package:equatable/equatable.dart';

part 'message_view_event.dart';
part 'message_view_state.dart';

class MessageViewBloc extends Bloc<MessageViewEvent, MessageViewState> {
  final GetAllMessages _getAllMessages;

  MessageViewBloc({
    required GetAllMessages getAllMessages,
  })  : _getAllMessages = getAllMessages,
        super(MessageInitial()) {
    on<FetchAllMessagesEvent>(_onFetchAllMessages);
    on<ReRenderMessagesEvent>(_onReRenderMessages);
  }

  FutureOr<void> _onFetchAllMessages(
    FetchAllMessagesEvent event,
    Emitter<MessageViewState> emit,
  ) async {
    if (event.isNew) {
      emit(MessageLoading());
    }

    final res = await _getAllMessages.call(
      GetAllMessagesParams(
        chatId: event.chatId,
        before: event.before,
      ),
    );

    res.fold(
      (l) => emit(MessageFailure(l.message)),
      (r) => emit(MessagesDisplaySuccess(r)),
    );
  }

  FutureOr<void> _onReRenderMessages(
    ReRenderMessagesEvent event,
    Emitter<MessageViewState> emit,
  ) async {
    emit(MessagesDisplaySuccess(event.messsages));
  }
}
