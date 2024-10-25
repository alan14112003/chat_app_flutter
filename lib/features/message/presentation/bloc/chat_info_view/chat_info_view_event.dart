part of 'chat_info_view_bloc.dart';

sealed class ChatInfoViewEvent extends Equatable {
  const ChatInfoViewEvent();

  @override
  List<Object> get props => [];
}

final class GetChatEvent extends ChatInfoViewEvent {
  final String chatId;

  const GetChatEvent({
    required this.chatId,
  });
}
