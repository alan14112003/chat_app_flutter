part of 'chat_view_bloc.dart';

sealed class ChatViewState extends Equatable {
  const ChatViewState();

  @override
  List<Object> get props => [];
}

final class ChatViewInitial extends ChatViewState {}

final class ChatViewLoading extends ChatViewState {}

final class ChatViewFailure extends ChatViewState {
  final String error;
  const ChatViewFailure(this.error);
}

final class ChatViewSuccess extends ChatViewState {
  final List<Chat> chats;

  const ChatViewSuccess({
    required this.chats,
  });

  @override
  // TODO: implement props
  List<Object> get props => [chats];
}
