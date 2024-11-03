import 'package:equatable/equatable.dart';


abstract class FriendViewEvent extends Equatable {
  const FriendViewEvent();
}

class LoadFriendsEvent extends FriendViewEvent {
  @override
  List<Object?> get props => [];
}

class LoadInviteFriendsEvent extends FriendViewEvent {
  @override
  List<Object?> get props => [];
}


