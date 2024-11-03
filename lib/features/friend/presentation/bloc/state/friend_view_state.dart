
import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:equatable/equatable.dart';

abstract class FriendViewState extends Equatable {
  const FriendViewState();
}


class FriendLoading extends FriendViewState {
  @override
  List<Object?> get props => [];
}

class FriendLoaded extends FriendViewState {
  final List<Friend> friend;
  const FriendLoaded(this.friend);

  @override
  List<Object?> get props => [friend];
}



class FriendError extends FriendViewState {
  final String message;
  const FriendError(this.message);

  @override
  List<Object?> get props => [message];
}
