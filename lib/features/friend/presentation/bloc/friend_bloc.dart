import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/friend.dart';
import '../../domain/repositories/friend_repository.dart';

abstract class FriendEvent {}

class LoadFriends extends FriendEvent {}

abstract class FriendState {}

class FriendLoading extends FriendState {}

class FriendLoaded extends FriendState {
  final List<Friend> friends;

  FriendLoaded(this.friends);
}

class FriendError extends FriendState {}

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final FriendRepository friendRepository;

  FriendBloc(this.friendRepository) : super(FriendLoading()) {
    on<LoadFriends>((event, emit) async {
      try {
        final friends = await friendRepository.getFriends();
        emit(FriendLoaded(friends));
      } catch (_) {
        emit(FriendError());
      }
    });
  }
}
