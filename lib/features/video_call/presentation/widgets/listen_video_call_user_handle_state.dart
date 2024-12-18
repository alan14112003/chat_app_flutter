import 'package:chat_app_flutter/core/constants/video_call_state_enum.dart';
import 'package:chat_app_flutter/features/video_call/presentation/bloc/video_call_user_handle/video_call_user_handle_bloc.dart';
import 'package:chat_app_flutter/features/video_call/presentation/cubit/video_call_handler/video_call_handle_cubit.dart';
import 'package:chat_app_flutter/features/video_call/utils/video_call_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListenVideoCallUserHandleState extends StatelessWidget {
  final Widget child;
  const ListenVideoCallUserHandleState({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoCallUserHandleBloc, VideoCallUserHandleState>(
      listener: (context, state) {
        if (state is JoinVideoCallSuccess) {
          if (state.videoCallState == VideoCallStateEnum.REQUEST) {
            final roomId = context.read<VideoCallHandleCubit>().state.roomId;
            if (roomId.isNotEmpty) {
              VideoCallUtil.requestCallSoundStart();
            }
          }
          context
              .read<VideoCallHandleCubit>()
              .setVideoCallState(state.videoCallState);
        }
      },
      child: child,
    );
  }
}
