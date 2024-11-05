part of 'add_group_bloc.dart';

abstract class AddGroupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddGroupRequested extends AddGroupEvent {
  final String groupName;
  final List<User> members;

  AddGroupRequested({required this.groupName, required this.members});

  @override
  List<Object> get props => [groupName, members];
}
