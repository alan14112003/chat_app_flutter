part of 'message_user_handle_bloc.dart';

sealed class MessageUserHandleState extends Equatable {
  const MessageUserHandleState();

  @override
  List<Object> get props => [];
}

final class MessageUserHandleInitial extends MessageUserHandleState {}

final class MessageUserHandleLoading extends MessageUserHandleState {}

final class SendMessageSuccess extends MessageUserHandleState {
  final List<Message> messages;

  const SendMessageSuccess({
    required this.messages,
  });

  @override
  List<Object> get props => [messages];
}

final class DeleteMessageSuccess extends MessageUserHandleState {
  final Message message;

  const DeleteMessageSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class RecallMessageSuccess extends MessageUserHandleState {
  final Message message;

  const RecallMessageSuccess({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

final class MessageUserHandleFailure extends MessageUserHandleState {
  final String error;

  const MessageUserHandleFailure(this.error);

  @override
  List<Object> get props => [error];
}
