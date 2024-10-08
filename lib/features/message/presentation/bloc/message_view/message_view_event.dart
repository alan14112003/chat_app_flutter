part of 'message_view_bloc.dart';

sealed class MessageViewEvent extends Equatable {
  const MessageViewEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllMessagesEvent extends MessageViewEvent {
  final String chatId;
  final int? before;
  final bool isNew;

  const FetchAllMessagesEvent({
    required this.chatId,
    this.before,
    this.isNew = true,
  });
}

final class ReRenderMessagesEvent extends MessageViewEvent {
  final List<Message> messsages;

  const ReRenderMessagesEvent({
    required this.messsages,
  });
}
