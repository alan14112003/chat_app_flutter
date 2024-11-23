part of 'message_user_handle_bloc.dart';

sealed class MessageUserHandleEvent extends Equatable {
  const MessageUserHandleEvent();

  @override
  List<Object> get props => [];
}

final class SendTextMessageEvent extends MessageUserHandleEvent {
  final String chatId;
  final String content;
  final int? replyId;
  final bool isChatBotContent;

  const SendTextMessageEvent({
    required this.chatId,
    required this.content,
    this.replyId,
    required this.isChatBotContent,
  });
}

final class SendImageMessageEvent extends MessageUserHandleEvent {
  final String chatId;
  final File content;
  final int? replyId;

  const SendImageMessageEvent({
    required this.chatId,
    required this.content,
    this.replyId,
  });
}

final class DeleteMessageEvent extends MessageUserHandleEvent {
  final Message message;

  const DeleteMessageEvent({
    required this.message,
  });
}

final class RecallMessageEvent extends MessageUserHandleEvent {
  final int messageId;

  const RecallMessageEvent({
    required this.messageId,
  });
}
