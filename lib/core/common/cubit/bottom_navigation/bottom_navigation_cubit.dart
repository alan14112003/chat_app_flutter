import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/constants/navigation_enum.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationInit());
  void changeIndex(NavigationEnum index) {
    emit(state.copyWith(
      current: index,
      prev: state.current,
    ));
  }

  void backIndex() {
    emit(state.copyWith(
      current: state.prev,
      prev: state.current,
    ));
  }
}
