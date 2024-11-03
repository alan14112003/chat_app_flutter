
import 'package:equatable/equatable.dart';

abstract class FriendUserHandleState extends Equatable {
  const FriendUserHandleState();
}


class FriendInitial extends FriendUserHandleState {
  @override
  List<Object?> get props => [];
}


class FriendLoading extends FriendUserHandleState {
  @override
  List<Object?> get props => [];
}

class FriendAddedSuccessfully extends FriendUserHandleState {
  @override
  List<Object?> get props => [];
}

class FriendRemoveSuccessfully extends FriendUserHandleState {
  @override
  List<Object?> get props => [];
}

class FriendDeleted extends FriendUserHandleState {
  final int id;
  const FriendDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

class FriendError extends FriendUserHandleState {
  final String message;
  const FriendError(this.message);

  @override
  List<Object?> get props => [message];
}
