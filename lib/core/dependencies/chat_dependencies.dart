import 'package:chat_app_flutter/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:chat_app_flutter/features/chat/data/sources/chat_remote_data_source.dart';
import 'package:chat_app_flutter/features/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app_flutter/features/chat/domain/usecases/get_all_chat.dart';
import 'package:chat_app_flutter/features/chat/domain/usecases/get_chat.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/chat_view/chat_view_bloc.dart';
import 'package:get_it/get_it.dart';

void chatDependencies(GetIt serviceLocator) {
  // data source
  serviceLocator
    ..registerFactory<ChatRemoteDataSource>(
      () => ChatRemoteDataSource(
        dio: serviceLocator(),
      ),
    )

    // repository
    ..registerFactory<ChatRepository>(
      () => ChatRepositoryImpl(
        chatRemoteDataSource: serviceLocator(),
      ),
    )

    // usecase
    ..registerFactory<GetAllChat>(
      () => GetAllChat(
        chatRepository: serviceLocator(),
      ),
    )
    ..registerFactory<GetChat>(
      () => GetChat(
        chatRepository: serviceLocator(),
      ),
    )

    // bloc
    ..registerFactory(
      () => ChatViewBloc(
        getAllChat: serviceLocator<GetAllChat>(),
      ),
    );
}
