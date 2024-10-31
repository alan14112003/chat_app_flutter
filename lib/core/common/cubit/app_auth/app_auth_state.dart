import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AppAuthState extends Equatable {
  const AppAuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AppAuthState {}

class Authenticated extends AppAuthState {
  final User user;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AppAuthState {}
