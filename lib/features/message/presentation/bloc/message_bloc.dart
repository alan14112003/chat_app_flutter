import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/delete_message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/get_all_messages.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/send_image_message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/send_text_message.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetAllMessages _getAllMessages;
  final SendTextMessage _sendTextMessage;
  final SendImageMessage _sendImageMessage;
  final DeleteMessage _deleteMessage;

  MessageBloc({
    required GetAllMessages getAllMessages,
    required SendTextMessage sendTextMessage,
    required SendImageMessage sendImageMessage,
    required DeleteMessage deleteMessage,
  })  : _getAllMessages = getAllMessages,
        _sendTextMessage = sendTextMessage,
        _sendImageMessage = sendImageMessage,
        _deleteMessage = deleteMessage,
        super(MessageInitial()) {
    on<FetchAllMessagesEvent>(_onFetchAllMessages);
    on<SendTextMessageEvent>(_onSendTextMessage);
    on<SendImageMessageEvent>(_onSendImageMessage);
    on<DeleteMessageEvent>(_onDeleteMessage);
  }

  FutureOr<void> _onFetchAllMessages(
    FetchAllMessagesEvent event,
    Emitter<MessageState> emit,
  ) async {
    if (event.isNew) {
      emit(MessageLoading());
    }

    final res = await _getAllMessages.call(
      GetAllMessagesParams(chatId: event.chatId),
    );

    res.fold(
      (l) => emit(MessageFailure(l.message)),
      (r) => emit(MessagesDisplaySuccess(r)),
    );
  }

  FutureOr<void> _onSendTextMessage(
    SendTextMessageEvent event,
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

  FutureOr<void> _onSendImageMessage(
    SendImageMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    final res = await _sendImageMessage.call(
      SendFileMessageParams(
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

  FutureOr<void> _onDeleteMessage(
    DeleteMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    final res = await _deleteMessage.call(
      DeleteMessageParams(
        message: event.message,
      ),
    );

    res.fold(
      (error) => emit(MessageFailure(error.message)),
      (messages) => add(
        FetchAllMessagesEvent(
          chatId: event.message.chatId!,
          isNew: false,
        ),
      ),
    );
  }
}
