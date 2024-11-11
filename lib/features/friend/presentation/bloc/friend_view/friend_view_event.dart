part of 'friend_view_bloc.dart';

sealed class FriendViewEvent extends Equatable {
  const FriendViewEvent();

  @override
  List<Object> get props => [];
}

class LoadAllFriendsEvent extends FriendViewEvent {}

class LoadRequestFriendsEvent extends FriendViewEvent {}

class ReloadAllFriendsEvent extends FriendViewEvent {}

class ReloadRequestFriendsEvent extends FriendViewEvent {}
