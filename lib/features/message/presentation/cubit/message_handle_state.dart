part of 'message_handle_cubit.dart';

class MessageHandleState extends Equatable {
  final String chatId;
  final Message? messageReply;
  final int? messageActive;
  final Message? messageReplyActive;
  final Message? messageReplyAfterActive;

  const MessageHandleState({
    required this.chatId,
    this.messageReply,
    this.messageActive,
    this.messageReplyActive,
    this.messageReplyAfterActive,
  });

  @override
  List<Object?> get props => [
        chatId,
        messageReply,
        messageActive,
        messageReplyActive,
        messageReplyAfterActive,
      ];

  MessageHandleState copyWith({
    String? chatId,
    Message? messageReply,
    int? messageId,
    Message? messageReplyActive,
    Message? messageReplyAfterActive,
  }) {
    return MessageHandleState(
      chatId: chatId ?? this.chatId,
      messageReply: messageReply,
      messageActive: messageId,
      messageReplyActive: messageReplyActive,
      messageReplyAfterActive: messageReplyAfterActive,
    );
  }

  MessageHandleState clear() {
    return MessageHandleState(
      chatId: '',
      messageReply: null,
      messageActive: null,
      messageReplyActive: null,
      messageReplyAfterActive: null,
    );
  }
}

final class MessageInitial extends MessageHandleState {
  const MessageInitial() : super(chatId: '');
}
