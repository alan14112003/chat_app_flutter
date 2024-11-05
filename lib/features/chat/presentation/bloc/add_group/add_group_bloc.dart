import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/features/chat/domain/usecases/add_group.dart';
import 'package:equatable/equatable.dart';

part 'add_group_event.dart';
part 'add_group_state.dart';

class AddGroupBloc extends Bloc<AddGroupEvent, AddGroupState> {
  final AddGroup _addGroup;

  AddGroupBloc({required AddGroup addGroup})
      : _addGroup = addGroup,
        super(AddGroupInitial()) {
    on<AddGroupRequested>(_onAddGroup);
  }

  FutureOr<void> _onAddGroup(
      AddGroupRequested event, Emitter<AddGroupState> emit) async {
    emit(AddGroupLoading());

    final result = await _addGroup.call(
      AddGroupParams(
        groupName: event.groupName,
        members: event.members,
      ),
    );

    result.fold(
      (failure) => emit(AddGroupFailure(failure.message)),
      (chat) => emit(AddGroupSuccess(chatId: chat)),
    );
  }
}
