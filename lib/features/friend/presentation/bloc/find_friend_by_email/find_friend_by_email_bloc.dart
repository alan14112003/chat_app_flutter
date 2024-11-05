import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/user_with_friend.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/find_friend_by_email.dart';
import 'package:equatable/equatable.dart';

part 'find_friend_by_email_event.dart';
part 'find_friend_by_email_state.dart';

class FindFriendByEmailBloc
    extends Bloc<FindFriendByEmailEvent, FindFriendByEmailState> {
  final FindFriendByEmail _findFriendByEmail;
  FindFriendByEmailBloc({required FindFriendByEmail findFriendByEmail})
      : _findFriendByEmail = findFriendByEmail,
        super(FindFriendByEmailInitial()) {
    on<FetchFindFriendByEmailEvent>(_onFetchFindFriendByEmail);
  }

  FutureOr<void> _onFetchFindFriendByEmail(
    FetchFindFriendByEmailEvent event,
    Emitter<FindFriendByEmailState> emit,
  ) async {
    emit(FindFriendByEmailLoading());
    final res = await _findFriendByEmail
        .call(FindFriendByEmailParams(email: event.email));
    res.fold(
      (l) {
        emit(FindFriendByEmailFailure(l.message));
      },
      (r) {
        emit(FindFriendByEmailDisplaySuccess(user: r));
      },
    );
  }
}
