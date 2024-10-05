part of 'message_bloc.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageState {}

final class MessageLoading extends MessageState {}

final class MessageFailure extends MessageState {
  final String error;
  const MessageFailure(this.error);
}

final class MessagesDisplaySuccess extends MessageState {
  final List<Message> messages;
  const MessagesDisplaySuccess(this.messages);

  @override
  List<Object> get props => [messages];
}
