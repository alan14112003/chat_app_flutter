part of 'chat_info_view_bloc.dart';

sealed class ChatInfoViewState extends Equatable {
  const ChatInfoViewState();

  @override
  List<Object> get props => [];
}

final class ChatInfoViewInitial extends ChatInfoViewState {}

final class ChatInfoViewLoading extends ChatInfoViewState {}

final class ChatInfoViewFailure extends ChatInfoViewState {
  final String error;
  const ChatInfoViewFailure(this.error);
}

final class ChatInfoViewSuccess extends ChatInfoViewState {
  final Chat chat;

  const ChatInfoViewSuccess({
    required this.chat,
  });

  @override
  List<Object> get props => [
        chat,
      ];
}
