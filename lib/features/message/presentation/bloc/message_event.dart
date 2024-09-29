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
