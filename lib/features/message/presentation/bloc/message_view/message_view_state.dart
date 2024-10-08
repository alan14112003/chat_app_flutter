part of 'message_view_bloc.dart';

sealed class MessageViewState extends Equatable {
  const MessageViewState();

  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageViewState {}

final class MessageLoading extends MessageViewState {}

final class MessageFailure extends MessageViewState {
  final String error;
  const MessageFailure(this.error);
}

final class MessagesDisplaySuccess extends MessageViewState {
  final List<Message> messages;
  const MessagesDisplaySuccess(this.messages);

  @override
  List<Object> get props => [messages];
}
