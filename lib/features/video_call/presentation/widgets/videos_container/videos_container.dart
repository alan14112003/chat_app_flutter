import 'package:chat_app_flutter/core/common/models/renderer.dart';
import 'package:chat_app_flutter/features/video_call/presentation/cubit/video_call_handler/video_call_handle_cubit.dart';
import 'package:chat_app_flutter/features/video_call/presentation/widgets/videos_container/widgets/video_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideosContainer extends StatelessWidget {
  const VideosContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VideoCallHandleCubit, VideoCallHandleState,
        List<Renderer>>(
      selector: (state) {
        return state.remoteRenderers;
      },
      builder: (context, remoteRenderers) {
        return Container(
          padding: const EdgeInsets.all(8.0),
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
          child: Center(
            child: _buildVideoLayout(remoteRenderers),
          ),
        );
      },
    );
  }

  Widget _buildVideoLayout(List<Renderer> remoteRenderers) {
    final rendererCount = remoteRenderers.length;

    if (rendererCount == 1) {
      return _buildFullScreenVideo(remoteRenderers, 0);
    }

    if (rendererCount == 2) {
      return Column(
        children: [
          _buildExpandedVideo(remoteRenderers, 0),
          _buildExpandedVideo(remoteRenderers, 1),
        ],
      );
    }

    int val = 2;
    int rows = (rendererCount / val).ceil();
    int cols = (rendererCount > val) ? val : rendererCount;

    return Column(
      children: List.generate(rows, (row) {
        return Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(cols, (col) {
              int index = row * cols + col;
              if (index < rendererCount) {
                return _buildExpandedVideo(remoteRenderers, index);
              } else {
                return SizedBox.shrink();
              }
            }),
          ),
        );
      }),
    );
  }

  // Hiển thị tên toàn màn hình
  Widget _buildFullScreenVideo(List<Renderer> remoteRenderers, int index) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: VideoElement(renderer: remoteRenderers[index]),
    );
  }

  // Hiển thị tên với Expanded
  Widget _buildExpandedVideo(List<Renderer> remoteRenderers, int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: VideoElement(renderer: remoteRenderers[index]),
      ),
    );
  }
}
