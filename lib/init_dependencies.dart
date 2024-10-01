import 'package:chat_app_flutter/core/utils/http.dart';
import 'package:chat_app_flutter/features/message/data/repositories/message_repository_impl.dart';
import 'package:chat_app_flutter/features/message/data/sources/message_remote_data_source.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/get_all_messages.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/send_text_message.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // khởi tạo preferences
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  // include
  _initMessage();

  // core project
  // http
  serviceLocator.registerLazySingleton(
    () => Http(preferences: preferences).dio,
  );
}

void _initMessage() {
  // data source
  serviceLocator
    ..registerFactory<MessageRemoteDataSource>(
      () => MessageRemoteDataSource(
        dio: serviceLocator(),
      ),
    )

    // repository
    ..registerFactory<MessageRepository>(
      () => MessageRepositoryImpl(
        messageRemoteDataSource: serviceLocator(),
      ),
    )

    // usecase
    ..registerFactory(
      () => GetAllMessages(
        messageRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SendTextMessage(
        messageRepository: serviceLocator(),
      ),
    )

    // bloc
    ..registerLazySingleton(
      () => MessageBloc(
        getAllMessages: serviceLocator(),
        sendTextMessage: serviceLocator(),
      ),
    );
}
