import 'package:equatable/equatable.dart';
import '../../domain/entities/friend.dart';

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
  final List<Friend> friends;
  const FriendLoaded(this.friends);

  @override
  List<Object?> get props => [friends];
}

class FriendAdded extends FriendState {
  final Friend friend;
  const FriendAdded(this.friend);

  @override
  List<Object?> get props => [friend];
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
