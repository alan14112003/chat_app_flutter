part of 'app_lifecycle_impl_cubit.dart';

class AppLifecycleImplState extends Equatable {
  final AppLifecycleState state;

  const AppLifecycleImplState({required this.state});

  @override
  List<Object> get props => [state];
}
