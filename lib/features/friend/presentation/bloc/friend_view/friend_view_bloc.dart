import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/all_friends.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/request_friends.dart';
import 'package:equatable/equatable.dart';

part 'friend_view_event.dart';
part 'friend_view_state.dart';

class FriendViewBloc extends Bloc<FriendViewEvent, FriendViewState> {
  final AllFriends _allFriends;
  final RequestFriends _requestFriends;

  FriendViewBloc({
    required AllFriends allFriends,
    required RequestFriends requestFriends,
  })  : _allFriends = allFriends,
        _requestFriends = requestFriends,
        super(FriendViewInitial()) {
    on<LoadAllFriendsEvent>(_onLoadAllFriends);
    on<LoadRequestFriendsEvent>(_onLoadRequestFriends);
    on<ReloadAllFriendsEvent>(_onReloadAllFriends);
    on<ReloadRequestFriendsEvent>(_onReloadRequestFriends);
  }

  Future<void> _onLoadAllFriends(
    LoadAllFriendsEvent event,
    Emitter<FriendViewState> emit,
  ) async {
    emit(FriendViewLoading());
    final res = await _allFriends.call(NoParams());

    res.fold(
      (error) => emit(FriendViewError(error.message)),
      (friends) => emit(FriendViewSuccess(friends: friends)),
    );
  }

  Future<void> _onReloadAllFriends(
    ReloadAllFriendsEvent event,
    Emitter<FriendViewState> emit,
  ) async {
    final res = await _allFriends.call(NoParams());

    res.fold(
      (error) => emit(FriendViewError(error.message)),
      (friends) => emit(FriendViewSuccess(friends: friends)),
    );
  }

  Future<void> _onLoadRequestFriends(
    LoadRequestFriendsEvent event,
    Emitter<FriendViewState> emit,
  ) async {
    emit(FriendViewLoading());
    final res = await _requestFriends.call(NoParams());

    res.fold(
      (error) => emit(FriendViewError(error.message)),
      (friends) => emit(FriendViewSuccess(friends: friends)),
    );
  }

  Future<void> _onReloadRequestFriends(
    ReloadRequestFriendsEvent event,
    Emitter<FriendViewState> emit,
  ) async {
    final res = await _requestFriends.call(NoParams());

    res.fold(
      (error) => emit(FriendViewError(error.message)),
      (friends) => emit(FriendViewSuccess(friends: friends)),
    );
  }
}
