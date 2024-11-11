import 'package:chat_app_flutter/features/friend/data/repositories/friend_repository_impl.dart';
import 'package:chat_app_flutter/features/friend/data/sources/friend_remote_data_source.dart';
import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/accept_friend.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/add_friend.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/find_friend_by_email.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/all_friends.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/request_friends.dart';
import 'package:chat_app_flutter/features/friend/domain/usecases/remove_friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/find_friend_by_email/find_friend_by_email_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_user_handle/friend_user_handle_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_view/friend_view_bloc.dart';
import 'package:get_it/get_it.dart';

void friendDependencies(GetIt serviceLocator) {
  serviceLocator
    ..registerFactory<FriendRemoteDataSource>(
      () => FriendRemoteDataSource(dio: serviceLocator()),
    )
    ..registerFactory<FriendRepository>(
      () => FriendRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    // use case
    ..registerFactory<AcceptFriend>(
      () => AcceptFriend(
        friendRepository: serviceLocator(),
      ),
    )
    ..registerFactory<AddFriend>(
      () => AddFriend(
        friendRepository: serviceLocator(),
      ),
    )
    ..registerFactory<AllFriends>(
      () => AllFriends(
        friendRepository: serviceLocator(),
      ),
    )
    ..registerFactory<FindFriendByEmail>(
      () => FindFriendByEmail(
        friendRepository: serviceLocator(),
      ),
    )
    ..registerFactory<RemoveFriend>(
      () => RemoveFriend(
        friendRepository: serviceLocator(),
      ),
    )
    ..registerFactory<RequestFriends>(
      () => RequestFriends(
        friendRepository: serviceLocator(),
      ),
    )
    // bloc
    ..registerFactory<FriendViewBloc>(
      () => FriendViewBloc(
        allFriends: serviceLocator(),
        requestFriends: serviceLocator(),
      ),
    )
    ..registerFactory<FriendUserHandleBloc>(
      () => FriendUserHandleBloc(
        addFriend: serviceLocator(),
        acceptFriend: serviceLocator(),
        removeFriend: serviceLocator(),
      ),
    )
    ..registerFactory<FindFriendByEmailBloc>(
      () => FindFriendByEmailBloc(
        findFriendByEmail: serviceLocator(),
      ),
    );
}
