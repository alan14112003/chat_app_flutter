part of 'bottom_navigation_cubit.dart';

sealed class BottomNavigationState extends Equatable {
  final NavigationEnum current;
  final NavigationEnum? prev;

  const BottomNavigationState({
    required this.current,
    required this.prev,
  });

  BottomNavigationState copyWith({
    NavigationEnum? current,
    NavigationEnum? prev,
  }) {
    return BottomNavigationInit(
      current: current ?? this.current,
      prev: prev ?? this.prev,
    );
  }

  @override
  List<Object?> get props => [current, prev];
}

final class BottomNavigationInit extends BottomNavigationState {
  const BottomNavigationInit({
    super.current = NavigationEnum.CHAT,
    super.prev,
  });
}
