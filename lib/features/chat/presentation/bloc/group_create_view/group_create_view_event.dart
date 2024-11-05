part of 'group_create_view_bloc.dart';

sealed class GroupCreateViewEvent extends Equatable {
  const GroupCreateViewEvent();

  @override
  List<Object> get props => [];
}

final class GetAllFiendEvent extends GroupCreateViewEvent {
  const GetAllFiendEvent();
}
