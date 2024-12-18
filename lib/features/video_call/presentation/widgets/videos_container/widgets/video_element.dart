import 'package:chat_app_flutter/core/common/models/renderer.dart';
import 'package:chat_app_flutter/features/video_call/presentation/bloc/video_call_user_handle/video_call_user_handle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoElement extends StatefulWidget {
  final Renderer renderer;
  const VideoElement({
    super.key,
    required this.renderer,
  });

  @override
  State<VideoElement> createState() => _VideoElementState();
}

class _VideoElementState extends State<VideoElement> {
  @override
  void initState() {
    super.initState();
    context
        .read<VideoCallUserHandleBloc>()
        .add(GetUserByIdEvent(userId: widget.renderer.name));
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.renderer.name;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.2),
            Colors.white.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withValues(alpha: 0.2),
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            if (widget.renderer.videoRenderer != null)
              Expanded(
                child: RTCVideoView(widget.renderer.videoRenderer!),
              ),
            BlocBuilder<VideoCallUserHandleBloc, VideoCallUserHandleState>(
              builder: (context, state) {
                if (state is GetUserByIdSuccess &&
                    state.user.id == widget.renderer.name) {
                  name = state.user.fullName!;
                }
                return Text(name);
              },
            ),
          ],
        ),
      ), // Hiển thị tên
    );
  }
}
