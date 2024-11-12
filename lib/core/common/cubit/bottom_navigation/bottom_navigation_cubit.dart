import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/constants/navigation_enum.dart';

class BottomNavigationCubit extends Cubit<NavigationEnum> {
  BottomNavigationCubit() : super(NavigationEnum.CHAT);
  void changeIndex(NavigationEnum index) {
    emit(index);
  }
}
