import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/chat/domain/usecases/get_all_friend.dart';
import 'package:equatable/equatable.dart';

part 'group_create_view_event.dart';
part 'group_create_view_state.dart';

class GroupCreateViewBloc
    extends Bloc<GroupCreateViewEvent, GroupCreateViewState> {
  final GetAllFriend _getAllFriend;

  GroupCreateViewBloc({
    required getAllFriend,
  })  : _getAllFriend = getAllFriend,
        super(GroupCreateViewInitial()) {
    on<GroupCreateViewEvent>(_onGetAllChat);
  }

  FutureOr<void> _onGetAllChat(
      GroupCreateViewEvent event, Emitter<GroupCreateViewState> emit) async {
    emit(GroupCreateViewLoading());
    final result = await _getAllFriend(NoParams());

    result.fold(
      (failure) => emit(GroupCreateViewFailure(failure.message)),
      (friend) => emit(GroupCreateViewSuccess(friends: friend)),
    );
  }
}
