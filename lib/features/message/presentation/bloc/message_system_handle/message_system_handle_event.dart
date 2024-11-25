part of 'message_system_handle_bloc.dart';

sealed class MessageSystemHandleEvent extends Equatable {
  const MessageSystemHandleEvent();

  @override
  List<Object> get props => [];
}

final class ReceiveNewMessageEvent extends MessageSystemHandleEvent {
  final Message message;

  const ReceiveNewMessageEvent({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class ReceivePinMessageEvent extends MessageSystemHandleEvent {
  final Message message;

  const ReceivePinMessageEvent({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class ReceiveRecallMessageEvent extends MessageSystemHandleEvent {
  final Message message;

  const ReceiveRecallMessageEvent({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
