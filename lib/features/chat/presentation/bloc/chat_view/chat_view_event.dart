part of 'chat_view_bloc.dart';

sealed class ChatViewEvent extends Equatable {
  const ChatViewEvent();

  @override
  List<Object> get props => [];
}

final class GetAllChatEvent extends ChatViewEvent {
  const GetAllChatEvent();
}
