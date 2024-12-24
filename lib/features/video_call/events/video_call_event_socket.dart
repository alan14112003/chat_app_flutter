import 'dart:async';
import 'dart:convert';

import 'package:chat_app_flutter/core/common/cubit/app_lifecycle_impl/app_lifecycle_impl_cubit.dart';
import 'package:chat_app_flutter/core/common/socket/socket_builder.dart';
import 'package:chat_app_flutter/core/constants/chat_event_enum.dart';
import 'package:chat_app_flutter/core/constants/video_call_state_enum.dart';
import 'package:chat_app_flutter/core/utils/local_notifications.dart';
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
  Timer? _timer;

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
      final videoCallId = 'video-call-$roomId'.hashCode;

      if (videoCallHandleState.roomId.isNotEmpty) {
        return;
      }

      context
          .read<VideoCallHandleCubit>()
          .receiveRequesVideoCall(roomId, VideoCallStateEnum.REQUEST);

      // Phát âm thanh lặp lại khi vào màn hình
      VideoCallUtil.notifyCallSoundStart();

      // Tự động quay lại màn hình trước đó sau 30 giây
      _timer = Timer(const Duration(seconds: 30), () {
        if (VideoCallUtil.isPlaying) {
          VideoCallUtil.stopNotificationSound();

          context.read<VideoCallHandleCubit>().setRoomId('');
          context
              .read<VideoCallHandleCubit>()
              .setVideoCallState(VideoCallStateEnum.UNKNOWN);

          final AppLifecycleState appLifecycleState =
              context.read<AppLifecycleImplCubit>().state.state;
          if (appLifecycleState == AppLifecycleState.resumed) {
            Navigator.of(context).pop(); // Quay lại màn hình trước đó
          }

          LocalNotifications.hideNotify(id: videoCallId);
        }
      });

      // kiểm tra thao tác hiển thị thông báo hoặc hiển thị màn hình
      final AppLifecycleState appLifecycleState =
          context.read<AppLifecycleImplCubit>().state.state;

      if (appLifecycleState == AppLifecycleState.paused) {
        Map<String, dynamic> payload = {
          "body": body as Map<String, dynamic>,
          "roomId": roomId,
        };

        String payloadJson = jsonEncode(payload);

        LocalNotifications.showNotify(
          id: videoCallId,
          title: 'Cuộc gọi đến ',
          content:
              '${body['sender']} đã gọi ${body['isGroup'] as bool ? 'đến nhóm ${body['groupName']}' : 'cho bạn'}',
          payload: 'video_call@:$payloadJson',
        );

        return;
      }

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
        VideoCallUtil.stopNotificationSound();
        VideoCallUtil.terminateCallSoundStart();

        // kiểm tra thao tác hiển thị thông báo hoặc hiển thị màn hình
        final AppLifecycleState appLifecycleState =
            context.read<AppLifecycleImplCubit>().state.state;

        if (_timer != null) {
          _timer!.cancel();
        }

        if (appLifecycleState == AppLifecycleState.paused) {
          final videoCallId = 'video-call-$roomId'.hashCode;
          LocalNotifications.hideNotify(id: videoCallId);
          context.read<VideoCallHandleCubit>().setRoomId('');
          context
              .read<VideoCallHandleCubit>()
              .setVideoCallState(VideoCallStateEnum.UNKNOWN);
          return;
        }

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
