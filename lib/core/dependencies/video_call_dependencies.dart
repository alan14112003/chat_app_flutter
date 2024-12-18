import 'package:chat_app_flutter/features/video_call/data/repositories/video_call_repository_impl.dart';
import 'package:chat_app_flutter/features/video_call/data/sources/video_call_remote_data_source.dart';
import 'package:chat_app_flutter/features/video_call/domain/repositories/video_call_repository.dart';
import 'package:chat_app_flutter/features/video_call/domain/usecases/close_video_call.dart';
import 'package:chat_app_flutter/features/video_call/domain/usecases/get_user_by_id_usecase.dart';
import 'package:chat_app_flutter/features/video_call/domain/usecases/join_video_call.dart';
import 'package:chat_app_flutter/features/video_call/domain/usecases/refuse_video_call.dart';
import 'package:chat_app_flutter/features/video_call/events/video_call_event_socket.dart';
import 'package:chat_app_flutter/features/video_call/presentation/bloc/video_call_user_handle/video_call_user_handle_bloc.dart';
import 'package:chat_app_flutter/features/video_call/presentation/cubit/video_call_handler/video_call_handle_cubit.dart';
import 'package:get_it/get_it.dart';

void videoCallDependencies(GetIt serviceLocator) {
  // Data Source
  serviceLocator
    ..registerFactory<VideoCallRemoteDataSource>(
      () => VideoCallRemoteDataSource(
        dio: serviceLocator(),
      ),
    )
    ..registerFactory<VideoCallRepository>(
      () => VideoCallRepositoryImpl(
        videoCallRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory<JoinVideoCall>(
      () => JoinVideoCall(
        videoCallRepository: serviceLocator(),
      ),
    )
    ..registerFactory<RefuseVideoCall>(
      () => RefuseVideoCall(
        videoCallRepository: serviceLocator(),
      ),
    )
    ..registerFactory<CloseVideoCall>(
      () => CloseVideoCall(
        videoCallRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetUserByIdUsecase(
        videoCallRepository: serviceLocator(),
      ),
    )
    ..registerFactory<VideoCallUserHandleBloc>(
      () => VideoCallUserHandleBloc(
        joinVideoCall: serviceLocator(),
        refuseVideoCall: serviceLocator(),
        closeVideoCall: serviceLocator(),
        getUserByIdUsecase: serviceLocator(),
      ),
    )
    ..registerFactory<VideoCallHandleCubit>(
      () => VideoCallHandleCubit(),
    )
    ..registerFactory<VideoCallEventSocket>(
      () => VideoCallEventSocket(
        socket: serviceLocator(),
      ),
    );
}
