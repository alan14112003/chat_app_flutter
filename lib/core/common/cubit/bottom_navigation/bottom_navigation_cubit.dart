import 'package:bloc/bloc.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit() : super(0);
  void changeIndex(int index) {
    emit(index);
  }
}
