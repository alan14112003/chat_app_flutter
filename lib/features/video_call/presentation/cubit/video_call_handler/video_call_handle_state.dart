part of 'video_call_handle_cubit.dart';

class VideoCallHandleState extends Equatable {
  final LocalStream? localStream;
  final bool isVideoEnable;
  final bool isAudioEnable;
  final bool showLocalRenderer;
  final List<Renderer> remoteRenderers;

  const VideoCallHandleState({
    required this.localStream,
    required this.isVideoEnable,
    required this.isAudioEnable,
    required this.showLocalRenderer,
    required this.remoteRenderers,
  });

  VideoCallHandleState copyWith({
    LocalStream? localStream,
    bool? isVideoEnable,
    bool? isAudioEnable,
    bool? showLocalRenderer,
    List<Renderer>? remoteRenderers,
  }) {
    return VideoCallHandleState(
      localStream: localStream ?? this.localStream,
      isVideoEnable: isVideoEnable ?? this.isVideoEnable,
      isAudioEnable: isAudioEnable ?? this.isAudioEnable,
      showLocalRenderer: showLocalRenderer ?? this.showLocalRenderer,
      remoteRenderers: remoteRenderers ?? this.remoteRenderers,
    );
  }

  @override
  List<Object?> get props => [
        localStream,
        isVideoEnable,
        isAudioEnable,
        showLocalRenderer,
        remoteRenderers,
      ];
}

// Lớp con cụ thể
class VideoCallInitialState extends VideoCallHandleState {
  const VideoCallInitialState()
      : super(
          localStream: null,
          isVideoEnable: true,
          isAudioEnable: true,
          showLocalRenderer: true,
          remoteRenderers: const [],
        );
}
