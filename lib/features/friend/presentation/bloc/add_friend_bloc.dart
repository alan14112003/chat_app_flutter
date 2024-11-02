import 'package:chat_app_flutter/features/friend/domain/usecases/add_friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/event/friend_event.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/state/friend_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddFriendBloc extends Bloc<FriendEvent, FriendState> {
  final AddFriend addFriend;

  AddFriendBloc({required this.addFriend}) : super(FriendInitial()) {
    on<AddFriendEvent>(_onAddFriend);
  }

  Future<void> _onAddFriend(AddFriendEvent event, Emitter<FriendState> emit) async {
    emit(FriendLoading());

    try {
      await addFriend(event.id);
      emit(FriendAddedSuccessfully());
    } catch (error) {
      emit(FriendError("Lỗi khi thêm bạn: ${error.toString()}"));
    }
  }
}
