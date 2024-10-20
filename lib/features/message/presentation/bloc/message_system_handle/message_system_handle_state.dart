part of 'message_system_handle_bloc.dart';

sealed class MessageSystemHandleState extends Equatable {
  const MessageSystemHandleState();

  @override
  List<Object> get props => [];
}

final class MessageSystemHandleInitial extends MessageSystemHandleState {}

final class MessageSystemHandleLoading extends MessageSystemHandleState {}

final class MessageSystemHandleFailure extends MessageSystemHandleState {
  final String error;

  const MessageSystemHandleFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class ReceiveNewMessageSuccess extends MessageSystemHandleState {
  final List<Message> messages;

  const ReceiveNewMessageSuccess(this.messages);
}

final class ReceivePinMessageSuccess extends MessageSystemHandleState {
  final List<Message> messages;

  const ReceivePinMessageSuccess(this.messages);
}
