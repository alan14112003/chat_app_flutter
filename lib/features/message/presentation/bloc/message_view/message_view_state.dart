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
  final bool isLast;

  const MessagesDisplaySuccess({
    required this.messages,
    required this.isLast,
  });

  @override
  List<Object> get props => [
        messages,
        isLast,
      ];
}
