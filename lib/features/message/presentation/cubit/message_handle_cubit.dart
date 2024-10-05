import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:equatable/equatable.dart';

part 'message_handle_state.dart';

class MessageHandleCubit extends Cubit<MessageHandleState> {
  MessageHandleCubit() : super(const MessageInitial());

  void selectedChat(String chatId) {
    emit(state.copyWith(chatId: chatId));
  }

  void activeMessage(int messageId) {
    if (messageId == state.messageActive) {
      emit(state.copyWith(messageId: null));
      return;
    }
    emit(state.copyWith(messageId: messageId));
  }

  void setMessageReply(Message? messageReply) {
    emit(state.copyWith(messageReply: messageReply));
  }
}
