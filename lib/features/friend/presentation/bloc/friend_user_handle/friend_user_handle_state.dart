part of 'friend_user_handle_bloc.dart';

sealed class FriendUserHandleState extends Equatable {
  const FriendUserHandleState();

  @override
  List<Object> get props => [];
}

final class FriendUserHandleInitial extends FriendUserHandleState {}

class FriendUserHandleLoading extends FriendUserHandleState {
  @override
  List<Object> get props => [];
}

class FriendAddedSuccessfully extends FriendUserHandleState {
  @override
  List<Object> get props => [];
}

class FriendAcceptedSuccessfully extends FriendUserHandleState {
  @override
  List<Object> get props => [];
}

class FriendDeletedSuccessfully extends FriendUserHandleState {
  @override
  List<Object> get props => [];
}

class FriendUserHandleError extends FriendUserHandleState {
  final String message;
  const FriendUserHandleError(this.message);

  @override
  List<Object> get props => [message];
}
