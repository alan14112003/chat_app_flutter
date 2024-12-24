import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_lifecycle_impl_state.dart';

class AppLifecycleImplCubit extends Cubit<AppLifecycleImplState> {
  AppLifecycleImplCubit()
      : super(
          AppLifecycleImplState(
            state: AppLifecycleState.hidden,
          ),
        );

  void setState(AppLifecycleState state) {
    emit(AppLifecycleImplState(state: state));
  }
}
