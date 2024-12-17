import 'package:chat_app_flutter/core/common/socket/socket_builder.dart';
import 'package:chat_app_flutter/core/constants/chat_event_enum.dart';
import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/screens/message_screen.dart';
import 'package:chat_app_flutter/features/video_call/presentation/cubit/video_call_handler/video_call_handle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class VideoCallEventSocket extends SocketListener {
  final Socket _socket;

  VideoCallEventSocket({
    required Socket socket,
  }) : _socket = socket;

  // receive terminate video call
  void onReceiveTerminateVideoCall(BuildContext context) {
    _socket.on(
      ChatEventEnum.VIDEO_CALL_TERMINATE,
      _handleReceiveTerminateVideoCall(context),
    );
  }

  void offReceiveTerminateVideoCall(BuildContext context) {
    _socket.off(
      ChatEventEnum.VIDEO_CALL_TERMINATE,
      _handleReceiveTerminateVideoCall(context),
    );
  }

  dynamic _handleReceiveTerminateVideoCall(BuildContext context) {
    return (chatId) {
      final videoCallHandleState = context.read<VideoCallHandleCubit>().state;
      if (videoCallHandleState.roomId == chatId) {
        showSnackBar(context, 'Cuộc gọi bị kết thúc do không có người trả lời');
        Navigator.pushReplacement(
          context,
          MessageScreen.route(
            context.read<MessageHandleCubit>().state.chatId,
          ),
        );
      }
    };
  }

  @override
  void initListeners(BuildContext context) {
    onReceiveTerminateVideoCall(context);
  }

  @override
  void removeListeners(BuildContext context) {
    offReceiveTerminateVideoCall(context);
  }
}
