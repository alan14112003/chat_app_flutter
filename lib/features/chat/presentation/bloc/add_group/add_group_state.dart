part of 'add_group_bloc.dart';

sealed class AddGroupState extends Equatable {
  const AddGroupState();

  @override
  List<Object> get props => [];
}

final class AddGroupInitial extends AddGroupState {}

final class AddGroupLoading extends AddGroupState {}

final class AddGroupFailure extends AddGroupState {
  final String error;
  const AddGroupFailure(this.error);
}

final class AddGroupSuccess extends AddGroupState {
  final String chatId;

  AddGroupSuccess({required this.chatId});

  @override
  List<Object> get props => [chatId];
}
