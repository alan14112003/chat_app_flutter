part of 'friend_user_handle_bloc.dart';

sealed class FriendUserHandleEvent extends Equatable {
  const FriendUserHandleEvent();

  @override
  List<Object> get props => [];
}

class AddFriendEvent extends FriendUserHandleEvent {
  final String friendId;

  const AddFriendEvent({required this.friendId});

  @override
  List<Object> get props => [friendId];
}

class AcceptFriendEvent extends FriendUserHandleEvent {
  final String friendId;

  const AcceptFriendEvent({required this.friendId});

  @override
  List<Object> get props => [friendId];
}

class DeleteFriendEvent extends FriendUserHandleEvent {
  final String friendId;

  const DeleteFriendEvent({required this.friendId});

  @override
  List<Object> get props => [friendId];
}
