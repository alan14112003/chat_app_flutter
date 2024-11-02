
import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:equatable/equatable.dart';

abstract class FriendState extends Equatable {
  const FriendState();
}


class FriendInitial extends FriendState {
  @override
  List<Object?> get props => [];
}

class FriendLoading extends FriendState {
  @override
  List<Object?> get props => [];
}

class FriendLoaded extends FriendState {
  final List<Friend> friend;
  const FriendLoaded(this.friend);

  @override
  List<Object?> get props => [friend];
}

// class FriendAdded extends FriendState {
//   final Friend friend;
//   const FriendAdded(this.friend);
//
//   @override
//   List<Object?> get props => [friend];
// }

class FriendAddedSuccessfully extends FriendState {
  @override
  List<Object?> get props => [];
}

class FriendRemoveSuccessfully extends FriendState {
  @override
  List<Object?> get props => [];
}

class FriendDeleted extends FriendState {
  final int id;
  const FriendDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

class FriendError extends FriendState {
  final String message;
  const FriendError(this.message);

  @override
  List<Object?> get props => [message];
}
