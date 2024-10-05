import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/get_all_messages.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/send_text_message.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetAllMessages _getAllMessages;
  final SendTextMessage _sendTextMessage;

  MessageBloc({
    required GetAllMessages getAllMessages,
    required SendTextMessage sendTextMessage,
  })  : _getAllMessages = getAllMessages,
        _sendTextMessage = sendTextMessage,
        super(MessageInitial()) {
    on<FetchAllMessagesEvent>(_onFetchAllMessages);
    on<SendMessageEvent>(_onSendMessage);
  }

  FutureOr<void> _onFetchAllMessages(
    FetchAllMessagesEvent event,
    Emitter<MessageState> emit,
  ) async {
    emit(MessageLoading());

    final res = await _getAllMessages.call(
      GetAllMessagesParams(chatId: event.chatId),
    );

    res.fold(
      (l) => emit(MessageFailure(l.message)),
      (r) => emit(MessagesDisplaySuccess(r)),
    );
  }

  FutureOr<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    final res = await _sendTextMessage.call(
      SendTextMessageParam(
        chatId: event.chatId,
        content: event.content,
        replyId: event.replyId,
      ),
    );

    res.fold(
      (error) => emit(MessageFailure(error.message)),
      (messages) => emit(MessagesDisplaySuccess(messages)),
    );
  }
}
