import 'package:chat_app_flutter/features/message/domain/usecases/receive_new_message.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_system_handle/message_system_handle_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_user_handle/message_user_handle_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:chat_app_flutter/features/message/data/repositories/message_repository_impl.dart';
import 'package:chat_app_flutter/features/message/data/sources/message_local_data_source.dart';
import 'package:chat_app_flutter/features/message/data/sources/message_remote_data_source.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/delete_message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/get_all_messages.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/recall_message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/send_image_message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/send_text_message.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_view/message_view_bloc.dart';

void messageDependencies(GetIt serviceLocator) {
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
    ..registerFactory(
      () => DeleteMessage(
        messageRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => RecallMessage(
        messageRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ReceiveNewMessage(
        messageRepository: serviceLocator(),
      ),
    )

    // bloc
    ..registerFactory(
      () => MessageViewBloc(
        getAllMessages: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => MessageUserHandleBloc(
        sendTextMessage: serviceLocator(),
        sendImageMessage: serviceLocator(),
        deleteMessage: serviceLocator(),
        recallMessage: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => MessageSystemHandleBloc(
        receiveNewMessage: serviceLocator(),
      ),
    );
}
