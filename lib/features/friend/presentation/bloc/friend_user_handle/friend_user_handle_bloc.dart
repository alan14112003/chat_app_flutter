import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/accept_friend.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/add_friend.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/remove_friend.dart';
import 'package:equatable/equatable.dart';

part 'friend_user_handle_event.dart';
part 'friend_user_handle_state.dart';

class FriendUserHandleBloc
    extends Bloc<FriendUserHandleEvent, FriendUserHandleState> {
  final AddFriend _addFriend;
  final AcceptFriend _acceptFriend;
  final RemoveFriend _removeFriend;

  FriendUserHandleBloc({
    required AddFriend addFriend,
    required AcceptFriend acceptFriend,
    required RemoveFriend removeFriend,
  })  : _addFriend = addFriend,
        _acceptFriend = acceptFriend,
        _removeFriend = removeFriend,
        super(FriendUserHandleInitial()) {
    on<AddFriendEvent>(_onAddFriend);
    on<AcceptFriendEvent>(_onAcceptFriend);
    on<DeleteFriendEvent>(_onDeleteFriend);
  }

  Future<void> _onAddFriend(
    AddFriendEvent event,
    Emitter<FriendUserHandleState> emit,
  ) async {
    emit(FriendUserHandleLoading());

    final res = await _addFriend(
      AddFriendParrams(friendId: event.friendId),
    );

    res.fold(
      (error) => emit(FriendUserHandleError(error.message)),
      (friends) => emit(FriendAddedSuccessfully()),
    );
  }

  Future<void> _onAcceptFriend(
    AcceptFriendEvent event,
    Emitter<FriendUserHandleState> emit,
  ) async {
    emit(FriendUserHandleLoading());

    final res = await _acceptFriend.call(
      AcceptFriendParams(friendId: event.friendId),
    );

    res.fold(
      (error) => emit(FriendUserHandleError(error.message)),
      (friends) => emit(FriendAcceptedSuccessfully()),
    );
  }

  Future<void> _onDeleteFriend(
    DeleteFriendEvent event,
    Emitter<FriendUserHandleState> emit,
  ) async {
    emit(FriendUserHandleLoading());

    final res = await _removeFriend.call(
      RemoveFriendParrams(friendId: event.friendId),
    );

    res.fold(
      (error) => emit(FriendUserHandleError(error.message)),
      (friends) => emit(FriendDeletedSuccessfully()),
    );
  }
}
