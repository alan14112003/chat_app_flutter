import 'package:chat_app_flutter/features/friend/domain/usecases/remove_friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/event/friend_event.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/state/friend_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RemoveInviteFriendBloc extends Bloc<FriendEvent, FriendState> {
  final RemoveFriend removeFriend;

  RemoveInviteFriendBloc({required this.removeFriend}) : super(FriendInitial()) {
    on<DeleteFriendEvent>(_onRemoveFriend);
  }

  Future<void> _onRemoveFriend(DeleteFriendEvent event, Emitter<FriendState> emit) async {
    emit(FriendLoading());

    try {
      await removeFriend(event.id);
      emit(FriendRemoveSuccessfully());
    } catch (error) {
      emit(FriendError("Lỗi khi thêm bạn: ${error.toString()}"));
    }
  }
}
