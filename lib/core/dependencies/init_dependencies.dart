import 'package:chat_app_flutter/core/common/data/repositories/upload_file_repository_impl.dart';
import 'package:chat_app_flutter/core/common/data/sources/upload_file_data_source.dart';
import 'package:chat_app_flutter/core/common/domain/repositories/upload_file_repository.dart';
import 'package:chat_app_flutter/core/common/domain/usecases/upload_file.dart';
import 'package:chat_app_flutter/core/dependencies/auth_dependencies.dart';
import 'package:chat_app_flutter/core/dependencies/chat_dependencies.dart';
import 'package:chat_app_flutter/core/dependencies/friend_dependencies.dart';
import 'package:chat_app_flutter/core/dependencies/message_dependencies.dart';
import 'package:chat_app_flutter/core/utils/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // khởi tạo preferences
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  // include
  _initUploadFile();
  authDependencies(serviceLocator);
  friendDependencies(serviceLocator);
  chatDependencies(serviceLocator);
  messageDependencies(serviceLocator);

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
