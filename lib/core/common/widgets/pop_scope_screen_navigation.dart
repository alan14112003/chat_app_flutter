import 'package:chat_app_flutter/core/common/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopScopeScreenNavigation extends StatelessWidget {
  final Widget child;

  const PopScopeScreenNavigation({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<BottomNavigationCubit>().backIndex();
      },
      child: child,
    );
  }
}
