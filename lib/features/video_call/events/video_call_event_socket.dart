import 'package:chat_app_flutter/core/common/socket/socket_builder.dart';
import 'package:chat_app_flutter/core/constants/chat_event_enum.dart';
import 'package:chat_app_flutter/core/constants/video_call_state_enum.dart';
import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/message/presentation/screens/message_screen.dart';
import 'package:chat_app_flutter/features/video_call/presentation/cubit/video_call_handler/video_call_handle_cubit.dart';
import 'package:chat_app_flutter/features/video_call/presentation/screen/notify_video_call_screen.dart';
import 'package:chat_app_flutter/features/video_call/utils/video_call_util.dart';
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
    return (roomId) {
      final videoCallHandleState = context.read<VideoCallHandleCubit>().state;
      if (videoCallHandleState.roomId == roomId) {
        showSnackBar(context, 'Cuộc gọi bị kết thúc do không có người trả lời');

        // bật âm thanh thông báo
        VideoCallUtil.stopNotificationSound();
        VideoCallUtil.terminateCallSoundStart();

        Navigator.pushReplacement(
          context,
          MessageScreen.route(
            roomId,
          ),
        );
      }
    };
  }

  void onReceiveRequestVideoCall(BuildContext context) {
    _socket.on(
      ChatEventEnum.VIDEO_CALL_REQUEST,
      _handleReceiveRequestVideoCall(context),
    );
  }

  void offReceiveRequestVideoCall(BuildContext context) {
    _socket.off(
      ChatEventEnum.VIDEO_CALL_REQUEST,
      _handleReceiveRequestVideoCall(context),
    );
  }

  dynamic _handleReceiveRequestVideoCall(BuildContext context) {
    return (data) {
      final [roomId, body] = data as List;
      final videoCallHandleState = context.read<VideoCallHandleCubit>().state;
      if (videoCallHandleState.roomId.isNotEmpty) {
        return;
      }
      context
          .read<VideoCallHandleCubit>()
          .receiveRequesVideoCall(roomId, VideoCallStateEnum.REQUEST);

      Navigator.push(
        context,
        NotifyVideoCallScreen.route(body as Map<String, dynamic>, roomId),
      );
    };
  }

  void onReceiveJoinVideoCall(BuildContext context) {
    _socket.on(
      ChatEventEnum.VIDEO_CALL_JOIN,
      _handleReceiveJoinVideoCall(context),
    );
  }

  void offReceiveJoinVideoCall(BuildContext context) {
    _socket.off(
      ChatEventEnum.VIDEO_CALL_JOIN,
      _handleReceiveJoinVideoCall(context),
    );
  }

  dynamic _handleReceiveJoinVideoCall(BuildContext context) {
    return (data) {
      print('_handleReceiveJoinVideoCall $data');
      final [roomId, ..._] = data as List;
      final videoCallHandleState = context.read<VideoCallHandleCubit>().state;
      if (videoCallHandleState.roomId.isEmpty ||
          videoCallHandleState.roomId != roomId) {
        return;
      }

      VideoCallUtil.stopNotificationSound();
      if (videoCallHandleState.videoCallState == VideoCallStateEnum.REQUEST) {
        context
            .read<VideoCallHandleCubit>()
            .setVideoCallState(VideoCallStateEnum.CONNECT);
      }
    };
  }

  void onReceiveRefuseVideoCall(BuildContext context) {
    _socket.on(
      ChatEventEnum.VIDEO_CALL_REFUSE,
      _handleReceiveRefuseVideoCall(context),
    );
  }

  void offReceiveRefuseVideoCall(BuildContext context) {
    _socket.off(
      ChatEventEnum.VIDEO_CALL_REFUSE,
      _handleReceiveRefuseVideoCall(context),
    );
  }

  dynamic _handleReceiveRefuseVideoCall(BuildContext context) {
    return (data) {
      print('_handleReceiveRefuseVideoCall $data');
      final [roomId, body as Map<String, dynamic>] = data as List;
      final videoCallHandleState = context.read<VideoCallHandleCubit>().state;
      if (videoCallHandleState.roomId.isEmpty ||
          videoCallHandleState.roomId != roomId) {
        return;
      }

      if (videoCallHandleState.videoCallState == VideoCallStateEnum.REQUEST &&
          !(body['isGroup'] as bool)) {
        // bật âm thanh thông báo
        VideoCallUtil.stopNotificationSound();
        VideoCallUtil.terminateCallSoundStart();

        Navigator.pushReplacement(
          context,
          MessageScreen.route(
            roomId,
          ),
        );
      }

      showSnackBar(context, '${body['sender']} đã từ chối cuộc gọi');
    };
  }

  void onReceiveCloseVideoCall(BuildContext context) {
    _socket.on(
      ChatEventEnum.VIDEO_CALL_CLOSE,
      _handleReceiveCloseVideoCall(context),
    );
  }

  void offReceiveCloseVideoCall(BuildContext context) {
    _socket.off(
      ChatEventEnum.VIDEO_CALL_CLOSE,
      _handleReceiveCloseVideoCall(context),
    );
  }

  dynamic _handleReceiveCloseVideoCall(BuildContext context) {
    return (data) {
      print('_handleReceiveCloseVideoCall $data');
      final [roomId, body as Map<String, dynamic>] = data as List;
      final videoCallHandleState = context.read<VideoCallHandleCubit>().state;
      if (videoCallHandleState.roomId.isEmpty ||
          videoCallHandleState.roomId != roomId) {
        return;
      }

      if (videoCallHandleState.videoCallState == VideoCallStateEnum.REQUEST) {
        // bật âm thanh thông báo
        VideoCallUtil.stopNotificationSound();
        VideoCallUtil.terminateCallSoundStart();

        Navigator.pushReplacement(
          context,
          MessageScreen.route(
            roomId,
          ),
        );
      }

      if (videoCallHandleState.videoCallState == VideoCallStateEnum.CONNECT &&
          body['videoCallPersonCount'] as int < 2) {
        Navigator.pushReplacement(
          context,
          MessageScreen.route(
            roomId,
          ),
        );
      }

      showSnackBar(context, '${body['sender']} đã kết thúc cuộc gọi');
    };
  }

  @override
  void initListeners(BuildContext context) {
    onReceiveTerminateVideoCall(context);
    onReceiveRequestVideoCall(context);
    onReceiveJoinVideoCall(context);
    onReceiveRefuseVideoCall(context);
    onReceiveCloseVideoCall(context);
  }

  @override
  void removeListeners(BuildContext context) {
    offReceiveTerminateVideoCall(context);
    offReceiveRequestVideoCall(context);
    offReceiveJoinVideoCall(context);
    offReceiveRefuseVideoCall(context);
    offReceiveCloseVideoCall(context);
  }
}
