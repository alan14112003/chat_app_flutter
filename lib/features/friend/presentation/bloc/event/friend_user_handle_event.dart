import 'package:equatable/equatable.dart';


abstract class FriendUserHandleEvent extends Equatable {
  const FriendUserHandleEvent();
}

class AcceptFriendEvent extends FriendUserHandleEvent {
  final String id;
  const AcceptFriendEvent(this.id);

  @override
  List<Object?> get props => [id];
}


class DeleteFriendEvent extends FriendUserHandleEvent {
  final String id;
  const DeleteFriendEvent(this.id);

  @override
  List<Object?> get props => [id];
}
