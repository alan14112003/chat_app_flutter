part of 'message_handle_cubit.dart';

class MessageHandleState extends Equatable {
  final String chatId;
  final Message? messageReply;
  final int? messageActive;
  final Message? messageReplyActive;
  final Message? messageReplyAfterActive;
  final bool isChatBotContent;

  const MessageHandleState({
    required this.chatId,
    this.messageReply,
    this.messageActive,
    this.messageReplyActive,
    this.messageReplyAfterActive,
    this.isChatBotContent = false,
  });

  @override
  List<Object?> get props => [
        chatId,
        messageReply,
        messageActive,
        messageReplyActive,
        messageReplyAfterActive,
        isChatBotContent,
      ];

  MessageHandleState copyWith({
    String? chatId,
    Message? messageReply,
    int? messageId,
    Message? messageReplyActive,
    Message? messageReplyAfterActive,
    bool? isChatBotContent,
  }) {
    return MessageHandleState(
      chatId: chatId ?? this.chatId,
      messageReply: messageReply,
      messageActive: messageId,
      messageReplyActive: messageReplyActive,
      messageReplyAfterActive: messageReplyAfterActive,
      isChatBotContent: isChatBotContent ?? this.isChatBotContent,
    );
  }

  MessageHandleState clear() {
    return MessageHandleState(
      chatId: '',
      messageReply: null,
      messageActive: null,
      messageReplyActive: null,
      messageReplyAfterActive: null,
      isChatBotContent: false,
    );
  }
}

final class MessageInitial extends MessageHandleState {
  const MessageInitial() : super(chatId: '');
}
