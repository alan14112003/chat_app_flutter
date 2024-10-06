import 'package:chat_app_flutter/core/common/data/repositories/upload_file_repository_impl.dart';
import 'package:chat_app_flutter/core/common/data/sources/upload_file_data_source.dart';
import 'package:chat_app_flutter/core/common/domain/repositories/upload_file_repository.dart';
import 'package:chat_app_flutter/core/common/domain/usecases/upload_file.dart';
import 'package:chat_app_flutter/core/utils/http.dart';
import 'package:chat_app_flutter/features/message/data/repositories/message_repository_impl.dart';
import 'package:chat_app_flutter/features/message/data/sources/message_local_data_source.dart';
import 'package:chat_app_flutter/features/message/data/sources/message_remote_data_source.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/get_all_messages.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/send_image_message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/send_text_message.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // khởi tạo preferences
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  // include
  _initUploadFile();
  _initMessage();

  // core project
  // Shared Preferences
  serviceLocator.registerLazySingleton(() => preferences);

  // http
  serviceLocator.registerLazySingleton(
    () => Http(preferences: preferences).dio,
  );
}

void _initUploadFile() {
  serviceLocator
    // data source
    ..registerFactory(
      () => UploadFileDataSource(
        dio: serviceLocator(),
      ),
    )
    // repository
    ..registerFactory<UploadFileRepository>(
      () => UploadFileRepositoryImpl(
        uploadFileDataSource: serviceLocator(),
      ),
    )
    // usecase
    ..registerFactory(
      () => UploadFile(
        uploadFileRepository: serviceLocator(),
      ),
    );
}

void _initMessage() {
  // data source
  serviceLocator
    ..registerFactory<MessageLocalDataSource>(
      () => MessageLocalDataSource(
        preferences: serviceLocator(),
      ),
    )
    ..registerFactory<MessageRemoteDataSource>(
      () => MessageRemoteDataSource(
        dio: serviceLocator(),
      ),
    )

    // repository
    ..registerFactory<MessageRepository>(
      () => MessageRepositoryImpl(
        messageLocalDataSource: serviceLocator(),
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
    ..registerFactory(
      () => SendImageMessage(
        messageRepository: serviceLocator(),
        uploadFile: serviceLocator(),
      ),
    )

    // bloc
    ..registerLazySingleton(
      () => MessageBloc(
          getAllMessages: serviceLocator(),
          sendTextMessage: serviceLocator(),
          sendImageMessage: serviceLocator()),
    );
}
