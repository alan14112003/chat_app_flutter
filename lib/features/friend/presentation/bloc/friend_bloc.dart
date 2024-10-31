import 'package:chat_app_flutter/features/friend/domain/entities/friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_event.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/get_friends.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final GetFriends getFriends;

  FriendBloc({required this.getFriends}) : super(FriendLoading()) {
    on<LoadFriendsEvent>(_onLoadFriends);
  }

  Future<void> _onLoadFriends(LoadFriendsEvent event, Emitter<FriendState> emit) async {
    emit(FriendLoading());
    try {
      final friends = await getFriends();
      emit(FriendLoaded(friends));
    } catch (error) {
      emit(FriendError("Lỗi khi tải danh sách bạn bè"));
    }
  }
}
