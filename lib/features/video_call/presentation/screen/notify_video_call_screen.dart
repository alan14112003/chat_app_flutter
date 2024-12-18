import 'dart:async';

import 'package:chat_app_flutter/core/constants/video_call_state_enum.dart';
import 'package:chat_app_flutter/features/video_call/presentation/bloc/video_call_user_handle/video_call_user_handle_bloc.dart';
import 'package:chat_app_flutter/features/video_call/presentation/cubit/video_call_handler/video_call_handle_cubit.dart';
import 'package:chat_app_flutter/features/video_call/presentation/screen/video_call_screen.dart';
import 'package:chat_app_flutter/features/video_call/utils/video_call_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotifyVideoCallScreen extends StatefulWidget {
  final String roomId;
  final Map<String, dynamic> body;
  static route(Map<String, dynamic> body, String roomId) => MaterialPageRoute(
        builder: (context) => NotifyVideoCallScreen(
          body: body,
          roomId: roomId,
        ),
      );

  const NotifyVideoCallScreen({
    super.key,
    required this.body,
    required this.roomId,
  });

  @override
  State<NotifyVideoCallScreen> createState() => _NotifyVideoCallScreenState();
}

class _NotifyVideoCallScreenState extends State<NotifyVideoCallScreen> {
  late Timer _timer;
  bool _isActiveCall = false;

  @override
  void initState() {
    super.initState();

    // Phát âm thanh lặp lại khi vào màn hình
    VideoCallUtil.notifyCallSoundStart();

    // Tự động quay lại màn hình trước đó sau 30 giây
    _timer = Timer(const Duration(seconds: 30), () {
      VideoCallUtil.stopNotificationSound();
      Navigator.of(context).pop(); // Quay lại màn hình trước đó
    });
  }

  @override
  void deactivate() {
    if (!_isActiveCall) {
      context
          .read<VideoCallHandleCubit>()
          .setVideoCallState(VideoCallStateEnum.UNKNOWN);

      context.read<VideoCallHandleCubit>().setRoomId('');
    }

    super.deactivate();
  }

  @override
  void dispose() {
    VideoCallUtil.stopNotificationSound(); // Dừng âm thanh khi màn hình bị hủy

    _timer.cancel(); // Hủy Timer khi màn hình bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title =
        '${widget.body['sender']} đã gọi ${widget.body['isGroup'] as bool ? 'đến nhóm ${widget.body['groupName']}' : 'cho bạn'}';
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE3F2FD), // Xanh nhạt
              Color(0xFFFCE4EC), // Hồng nhạt
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.3),
                Colors.white.withValues(alpha: 0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: -5,
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.call,
                      size: 100,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const CircleBorder(),
                          padding: EdgeInsets.all(8),
                        ),
                        onPressed: () {
                          setState(() {
                            _isActiveCall = true;
                          });
                          context
                              .read<VideoCallUserHandleBloc>()
                              .add(JoinVideoCallEvent(chatId: widget.roomId));

                          Navigator.of(context).pushReplacement(
                            VideoCallScreen.route(widget.roomId),
                          );
                        },
                        child: Icon(
                          Icons.video_call_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: const CircleBorder(),
                          padding: EdgeInsets.all(8),
                        ),
                        onPressed: () {
                          context.read<VideoCallUserHandleBloc>().add(
                                RefuseVideoCallEvent(chatId: widget.roomId),
                              );

                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
