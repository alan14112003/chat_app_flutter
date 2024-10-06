part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllMessagesEvent extends MessageEvent {
  final String chatId;

  const FetchAllMessagesEvent({required this.chatId});
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
