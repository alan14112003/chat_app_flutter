
import 'package:chat_app_flutter/features/friend/domain/usecases/get_invite_friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/event/friend_view_event.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/state/friend_view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/get_friends.dart';

class FriendViewBloc extends Bloc<FriendViewEvent, FriendViewState> {
  final GetFriends? getFriends;
  final GetInviteFriends? getInviteFriends;


  FriendViewBloc({
    this.getFriends,
    this.getInviteFriends,

  }) : super(FriendLoading()) {
      on<LoadFriendsEvent>(_onLoadFriends);
      on<LoadInviteFriendsEvent>(_onLoadInviteFriends);
  }

  Future<void> _onLoadFriends(LoadFriendsEvent event, Emitter<FriendViewState> emit) async {
    emit(FriendLoading());
    try {
      final friends = await getFriends!();
      emit(FriendLoaded(friends));
    } catch (error) {
      emit(FriendError("Lỗi khi tải danh sách bạn bè"));
    }
  }

  Future<void> _onLoadInviteFriends(LoadInviteFriendsEvent event, Emitter<FriendViewState> emit) async {
    emit(FriendLoading());
    try {
      final inviteFriends = await getInviteFriends!();
      emit(FriendLoaded(inviteFriends));
    } catch (error) {
      emit(FriendError("Lỗi khi tải danh sách lời mời kết bạn"));
    }
  }
}