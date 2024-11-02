import 'package:chat_app_flutter/features/friend/domain/usecases/get_invite_friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/event/friend_event.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/state/friend_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InviteFriendsBloc extends Bloc<FriendEvent, FriendState> {
  final GetInviteFriends getInviteFriends;

  InviteFriendsBloc({required this.getInviteFriends}) : super(FriendLoading()) {
    on<LoadFriendsEvent>(_onLoadFriends);

  }

  Future<void> _onLoadFriends(LoadFriendsEvent event, Emitter<FriendState> emit) async {
    emit(FriendLoading());
    try {
      final friends = await getInviteFriends();
      emit(FriendLoaded(friends));
    } catch (error) {
      emit(FriendError("Lỗi khi tải danh sách lời mời kết bạn"));
    }
  }
}
