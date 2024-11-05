import 'package:chat_app_flutter/features/friend/data/repositories/friend_repository_impl.dart';
import 'package:chat_app_flutter/features/friend/data/sources/friend_remote_data_source.dart';
import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/accept_friend.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/find_friend_by_email.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/get_friends.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/get_invite_friend.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/remove_friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/find_friend_by_email/find_friend_by_email_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_user_handle_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_view_bloc.dart';
import 'package:get_it/get_it.dart';

void friendDependencies(GetIt serviceLocator) {
  // Đăng ký các use case
  serviceLocator
    ..registerLazySingleton(
        () => GetFriends(friendRepository: serviceLocator()))
    ..registerLazySingleton(
        () => GetInviteFriends(friendRepository: serviceLocator()))
    ..registerLazySingleton(
        () => AcceptFriend(friendRepository: serviceLocator()))
    ..registerLazySingleton(
        () => RemoveFriend(friendRepository: serviceLocator()))
    ..registerFactory(
      () => FindFriendByEmail(friendRepository: serviceLocator()),
    );

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
  serviceLocator.registerFactory<FriendViewBloc>(() => FriendViewBloc(
        getFriends:
            serviceLocator<GetFriends>(), // Lấy GetFriends từ serviceLocator
        getInviteFriends: serviceLocator<
            GetInviteFriends>(), // Lấy GetInviteFriends từ serviceLocator
      ));

  serviceLocator
      .registerFactory<FriendUserHandleBloc>(() => FriendUserHandleBloc(
            acceptFriend: serviceLocator<AcceptFriend>(),
            removeFriend: serviceLocator<RemoveFriend>(),
          ));

  serviceLocator.registerFactory(
    () => FindFriendByEmailBloc(
      findFriendByEmail: serviceLocator<FindFriendByEmail>(),
    ),
  );
}
