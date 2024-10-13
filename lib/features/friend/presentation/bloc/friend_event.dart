import 'package:equatable/equatable.dart';
import '../../domain/entities/friend.dart';

abstract class FriendEvent extends Equatable {
  const FriendEvent();
}

class LoadFriendsEvent extends FriendEvent {
  @override
  List<Object?> get props => [];
}

class AddFriendEvent extends FriendEvent {
  final Friend friend;
  const AddFriendEvent(this.friend);

  @override
  List<Object?> get props => [friend];
}

class DeleteFriendEvent extends FriendEvent {
  final int id;
  const DeleteFriendEvent(this.id);

  @override
  List<Object?> get props => [id];
}
