part of 'group_create_view_bloc.dart';

sealed class GroupCreateViewState extends Equatable {
  const GroupCreateViewState();

  @override
  List<Object> get props => [];
}

final class GroupCreateViewInitial extends GroupCreateViewState {}

final class GroupCreateViewLoading extends GroupCreateViewState {}

final class GroupCreateViewFailure extends GroupCreateViewState {
  final String error;
  const GroupCreateViewFailure(this.error);
}

final class GroupCreateViewSuccess extends GroupCreateViewState {
  final List<Friend> friends;

  const GroupCreateViewSuccess({
    required this.friends,
  });

  @override
  // TODO: implement props
  List<Object> get props => [friends];
}
