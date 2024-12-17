import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/screens/message_screen.dart';
import 'package:chat_app_flutter/features/video_call/presentation/cubit/video_call_handler/video_call_handle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class ActionsHandler extends StatefulWidget {
  const ActionsHandler({super.key});

  @override
  State<ActionsHandler> createState() => _ActionsHandlerState();
}

class _ActionsHandlerState extends State<ActionsHandler> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(170, 0, 0, 0),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, // Nền trong suốt
                shadowColor: Colors.transparent, // Loại bỏ hiệu ứng bóng
                elevation: 0, // Loại bỏ độ nổi
              ),
              onPressed: () {
                context.read<VideoCallHandleCubit>().toggleVideo();
              },
              child: BlocSelector<VideoCallHandleCubit, VideoCallHandleState,
                  bool>(
                selector: (state) {
                  return state.isVideoEnable;
                },
                builder: (context, isVideoEnable) {
                  return Icon(
                    isVideoEnable ? Icons.videocam : Icons.videocam_off,
                    size: 28,
                    color: Colors.white,
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, // Nền trong suốt
                shadowColor: Colors.transparent, // Loại bỏ hiệu ứng bóng
                elevation: 0, // Loại bỏ độ nổi
              ),
              onPressed: () {
                context.read<VideoCallHandleCubit>().toggleAudio();
              },
              child: BlocSelector<VideoCallHandleCubit, VideoCallHandleState,
                  bool>(
                selector: (state) {
                  return state.isAudioEnable;
                },
                builder: (context, isAudioEnable) {
                  return Icon(
                    isAudioEnable ? Icons.mic : Icons.mic_off,
                    size: 28,
                    color: Colors.white,
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, // Nền trong suốt
                shadowColor: Colors.transparent, // Loại bỏ hiệu ứng bóng
                elevation: 0, // Loại bỏ độ nổi
              ),
              onPressed: () {
                final localStream =
                    context.read<VideoCallHandleCubit>().state.localStream;
                if (localStream == null) {
                  return;
                }
                final videoTrack = localStream.getTrack('video');
                if (videoTrack == null) {
                  return;
                }
                Helper.switchCamera(videoTrack);
              },
              child: Icon(
                Icons.cameraswitch,
                size: 28,
                color: Colors.white,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Nền trong suốt
                shadowColor: Colors.transparent, // Loại bỏ hiệu ứng bóng
                elevation: 0, // Loại bỏ độ nổi
                shape: const CircleBorder(),
                padding: EdgeInsets.all(6),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MessageScreen.route(
                    context.read<MessageHandleCubit>().state.chatId,
                  ),
                );
              },
              child: Icon(
                Icons.phone,
                size: 28,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
