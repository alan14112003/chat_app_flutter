part of 'find_friend_by_email_bloc.dart';

sealed class FindFriendByEmailState extends Equatable {
  const FindFriendByEmailState();

  @override
  List<Object> get props => [];
}

final class FindFriendByEmailInitial extends FindFriendByEmailState {}

final class FindFriendByEmailLoading extends FindFriendByEmailState {}

final class FindFriendByEmailFailure extends FindFriendByEmailState {
  final String error;
  const FindFriendByEmailFailure(this.error);
}

final class FindFriendByEmailDisplaySuccess extends FindFriendByEmailState {
  final UserWithFriend? user;

  const FindFriendByEmailDisplaySuccess({
    required this.user,
  });

  @override
  List<Object> get props => [];
}
