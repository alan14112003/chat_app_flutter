import 'package:chat_app_flutter/features/friend/domain/usecases/accept_friend.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/remove_friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/event/friend_user_handle_event.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/state/friend_user_handle_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FriendUserHandleBloc extends Bloc<FriendUserHandleEvent, FriendUserHandleState> {
  final AcceptFriend? acceptFriend;
  final RemoveFriend? removeFriend;



  FriendUserHandleBloc({
    this.acceptFriend,
    this.removeFriend,

  }) : super(FriendInitial()) {
    on<AcceptFriendEvent>(_onAcceptFriend);
    on<DeleteFriendEvent>(_onRemoveFriend);
  }

  Future<void> _onAcceptFriend(AcceptFriendEvent event, Emitter<FriendUserHandleState> emit) async {
    emit(FriendLoading());
    try {
      await acceptFriend!(event.id);
      emit(FriendAddedSuccessfully());
    } catch (error) {
      emit(FriendError("Lỗi khi tải danh sách bạn bè"));
    }
  }

  Future<void> _onRemoveFriend(DeleteFriendEvent event, Emitter<FriendUserHandleState> emit) async {
    emit(FriendLoading());
    try {
      await removeFriend!(event.id);
      emit(FriendRemoveSuccessfully());
    } catch (error) {
      emit(FriendError("Lỗi khi tải danh sách lời mời kết bạn"));
    }
  }
}