part of 'message_handle_cubit.dart';

class MessageHandleState extends Equatable {
  final String chatId;
  final Message? messageReply;
  final int? messageActive;
  final Message? messageReplyActive;

  const MessageHandleState({
    required this.chatId,
    this.messageReply,
    this.messageActive,
    this.messageReplyActive,
  });

  @override
  List<Object?> get props =>
      [chatId, messageReply, messageActive, messageReplyActive];

  MessageHandleState copyWith({
    String? chatId,
    Message? messageReply,
    int? messageId,
    Message? messageReplyActive,
  }) {
    return MessageHandleState(
      chatId: chatId ?? this.chatId,
      messageReply: messageReply,
      messageActive: messageId,
      messageReplyActive: messageReplyActive,
    );
  }
}

final class MessageInitial extends MessageHandleState {
  const MessageInitial() : super(chatId: '');
}
