import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/renderer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ion/flutter_ion.dart';

part 'video_call_handle_state.dart';

class VideoCallHandleCubit extends Cubit<VideoCallHandleState> {
  VideoCallHandleCubit() : super(VideoCallInitialState());

  void setLocalStream(LocalStream localStream) {
    emit(state.copyWith(localStream: localStream));
  }

  void setRemoteRenderers(List<Renderer> remoteRenderers) async {
    emit(state.copyWith(remoteRenderers: remoteRenderers));
  }

  void toggleVideo() {
    if (state.localStream == null) {
      return;
    }
    final videoTrack = state.localStream!.getTrack('video');
    if (videoTrack == null) {
      return;
    }
    videoTrack.enabled = !state.isVideoEnable;
    emit(state.copyWith(isVideoEnable: !state.isVideoEnable));
  }

  void toggleAudio() {
    if (state.localStream == null) {
      return;
    }
    final audioTrack = state.localStream!.getTrack('audio');
    if (audioTrack == null) {
      return;
    }
    audioTrack.enabled = !state.isAudioEnable;
    emit(state.copyWith(isAudioEnable: !state.isAudioEnable));
  }

  void toggleShowLocalRenderer(isShowLocalRenderer) {
    emit(state.copyWith(showLocalRenderer: isShowLocalRenderer));
  }

  void cleanData() {
    emit(VideoCallHandleState(
      localStream: null,
      isVideoEnable: true,
      isAudioEnable: true,
      showLocalRenderer: true,
      remoteRenderers: [],
    ));
  }
}
