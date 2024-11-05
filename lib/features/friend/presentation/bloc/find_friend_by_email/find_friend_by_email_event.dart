part of 'find_friend_by_email_bloc.dart';

sealed class FindFriendByEmailEvent extends Equatable {
  const FindFriendByEmailEvent();

  @override
  List<Object> get props => [];
}

final class FetchFindFriendByEmailEvent extends FindFriendByEmailEvent {
  final String email;

  const FetchFindFriendByEmailEvent({required this.email});

  @override
  List<Object> get props => [email];
}
