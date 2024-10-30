import 'package:chat_app_flutter/features/friend/data/repositories/friend_repository_impl.dart';
import 'package:chat_app_flutter/features/friend/data/sources/friend_remote_data_source.dart';
import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/get_friends.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/add_friend.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/remove_friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_bloc.dart';
import 'package:get_it/get_it.dart';

  void friendDependencies(GetIt serviceLocator) {
    // Đăng ký các use case
    serviceLocator
      ..registerLazySingleton(() => GetFriends(friendRepository: serviceLocator()))
      ..registerLazySingleton(() => AddFriend(friendRepository: serviceLocator()))
      ..registerLazySingleton(() => RemoveFriend(friendRepository: serviceLocator()));

    // Đăng ký repository
    // Register Friend dependencies
    serviceLocator
      ..registerLazySingleton<FriendRemoteDataSource>(
            () => FriendRemoteDataSource(dio: serviceLocator()),
      )
      ..registerLazySingleton<FriendRepository>(
            () => FriendRepositoryImpl(
          remoteDataSource: serviceLocator(),
        ),
      );

    // Đăng ký Bloc
    serviceLocator.registerFactory<FriendBloc>(() => FriendBloc(getFriends: serviceLocator()));
  }
