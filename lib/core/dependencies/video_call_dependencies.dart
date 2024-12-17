import 'package:chat_app_flutter/features/video_call/presentation/cubit/video_call_handler/video_call_handle_cubit.dart';
import 'package:get_it/get_it.dart';

void videoCallDependencies(GetIt serviceLocator) {
  // Data Source
  serviceLocator.registerFactory<VideoCallHandleCubit>(
    () => VideoCallHandleCubit(),
  );
}
