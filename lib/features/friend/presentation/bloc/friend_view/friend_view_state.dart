part of 'friend_view_bloc.dart';

sealed class FriendViewState extends Equatable {
  const FriendViewState();

  @override
  List<Object> get props => [];
}

final class FriendViewInitial extends FriendViewState {}

class FriendViewLoading extends FriendViewState {}

class FriendViewSuccess extends FriendViewState {
  final List<Friend> friends;

  const FriendViewSuccess({
    required this.friends,
  });

  @override
  List<Object> get props => [friends];
}

class FriendViewError extends FriendViewState {
  final String message;
  const FriendViewError(this.message);

  @override
  List<Object> get props => [message];
}
