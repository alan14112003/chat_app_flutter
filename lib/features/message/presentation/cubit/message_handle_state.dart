part of 'message_handle_cubit.dart';

class MessageHandleState extends Equatable {
  final String chatId;
  final Message? messageReply;
  final int? messageActive;

  const MessageHandleState({
    required this.chatId,
    this.messageReply,
    this.messageActive,
  });

  @override
  List<Object?> get props => [chatId, messageReply, messageActive];

  MessageHandleState copyWith({
    String? chatId,
    Message? messageReply,
    int? messageId,
  }) {
    return MessageHandleState(
      chatId: chatId ?? this.chatId,
      messageReply: messageReply,
      messageActive: messageId,
    );
  }
}

final class MessageInitial extends MessageHandleState {
  const MessageInitial() : super(chatId: '');
}
