part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllMessagesEvent extends MessageEvent {
  final String chatId;
  final int? before;
  final bool isNew;

  const FetchAllMessagesEvent({
    required this.chatId,
    this.before,
    this.isNew = true,
  });
}

final class SendTextMessageEvent extends MessageEvent {
  final String chatId;
  final String content;
  final int? replyId;

  const SendTextMessageEvent({
    required this.chatId,
    required this.content,
    this.replyId,
  });
}

final class SendImageMessageEvent extends MessageEvent {
  final String chatId;
  final File content;
  final int? replyId;

  const SendImageMessageEvent({
    required this.chatId,
    required this.content,
    this.replyId,
  });
}

final class DeleteMessageEvent extends MessageEvent {
  final Message message;

  const DeleteMessageEvent({
    required this.message,
  });
}

final class RecallMessageEvent extends MessageEvent {
  final int messageId;

  const RecallMessageEvent({
    required this.messageId,
  });
}

final class ReceiveNewMessageEvent extends MessageEvent {
  final Message message;

  const ReceiveNewMessageEvent({
    required this.message,
  });
}
