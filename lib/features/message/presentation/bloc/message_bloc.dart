import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/get_all_messages.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetAllMessages _getAllMessages;

  MessageBloc({
    required GetAllMessages getAllMessages,
  })  : _getAllMessages = getAllMessages,
        super(MessageInitial()) {
    on<MessageEvent>(
      (event, emit) => emit(MessageLoading()),
    );
    on<FetchAllMessagesEvent>(_onFetchAllMessages);
  }

  FutureOr<void> _onFetchAllMessages(
    FetchAllMessagesEvent event,
    Emitter<MessageState> emit,
  ) async {
    final res = await _getAllMessages(event.chatId);

    res.fold(
      (l) => emit(MessageFailure(l.message)),
      (r) => emit(MessagesDisplaySuccess(r)),
    );
  }
}
