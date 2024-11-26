import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/delete_message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/recall_message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/send_image_message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/send_text_message.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:equatable/equatable.dart';

part 'message_user_handle_event.dart';
part 'message_user_handle_state.dart';

class MessageUserHandleBloc
    extends Bloc<MessageUserHandleEvent, MessageUserHandleState> {
  final SendTextMessage _sendTextMessage;
  final SendImageMessage _sendImageMessage;
  final DeleteMessage _deleteMessage;
  final RecallMessage _recallMessage;

  MessageUserHandleBloc({
    required SendTextMessage sendTextMessage,
    required SendImageMessage sendImageMessage,
    required DeleteMessage deleteMessage,
    required RecallMessage recallMessage,
  })  : _sendTextMessage = sendTextMessage,
        _sendImageMessage = sendImageMessage,
        _deleteMessage = deleteMessage,
        _recallMessage = recallMessage,
        super(MessageUserHandleInitial()) {
    on<MessageUserHandleEvent>(_onMessageUserHandleEvent);
    on<SendTextMessageEvent>(_onSendTextMessage);
    on<SendImageMessageEvent>(_onSendImageMessage);
    on<DeleteMessageEvent>(_onDeleteMessage);
    on<RecallMessageEvent>(_onRecallMessage);
  }

  FutureOr<void> _onMessageUserHandleEvent(
    MessageUserHandleEvent event,
    Emitter<MessageUserHandleState> emit,
  ) {
    emit(MessageUserHandleLoading());
  }

  FutureOr<void> _onSendTextMessage(
    SendTextMessageEvent event,
    Emitter<MessageUserHandleState> emit,
  ) async {
    final geminiContent = HandleMessageUtil.ensureGeminiPrefix(event.content);

    final res = await _sendTextMessage.call(
      SendTextMessageParam(
        chatId: event.chatId,
        content: event.isChatBotContent ? geminiContent : event.content,
        replyId: event.replyId,
        isChatBotContent: event.isChatBotContent,
      ),
    );

    res.fold(
      (error) => emit(MessageUserHandleFailure(error.message)),
      (messages) => emit(SendMessageSuccess(messages: messages)),
    );
  }

  FutureOr<void> _onSendImageMessage(
    SendImageMessageEvent event,
    Emitter<MessageUserHandleState> emit,
  ) async {
    final res = await _sendImageMessage.call(
      SendFileMessageParams(
        chatId: event.chatId,
        content: event.content,
        replyId: event.replyId,
      ),
    );

    res.fold(
      (error) => emit(MessageUserHandleFailure(error.message)),
      (messages) => emit(SendMessageSuccess(messages: messages)),
    );
  }

  FutureOr<void> _onDeleteMessage(
    DeleteMessageEvent event,
    Emitter<MessageUserHandleState> emit,
  ) async {
    final res = await _deleteMessage.call(
      DeleteMessageParams(
        message: event.message,
      ),
    );

    res.fold(
      (error) => emit(MessageUserHandleFailure(error.message)),
      (isSuccess) => emit(DeleteMessageSuccess(message: event.message)),
    );
  }

  FutureOr<void> _onRecallMessage(
    RecallMessageEvent event,
    Emitter<MessageUserHandleState> emit,
  ) async {
    final res = await _recallMessage.call(
      RecallMessageParams(messageId: event.messageId),
    );

    res.fold(
      (error) => emit(MessageUserHandleFailure(error.message)),
      (message) => emit(RecallMessageSuccess(message: message)),
    );
  }
}
