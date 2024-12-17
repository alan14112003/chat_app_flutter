import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class Renderer extends Equatable {
  final String streamId;
  final String name;
  final RTCVideoRenderer? videoRenderer;
  final bool isSpeaker;

  const Renderer({
    required this.streamId,
    required this.name,
    this.videoRenderer,
    required this.isSpeaker,
  });

  Renderer copyWith({
    String? name,
    RTCVideoRenderer? videoRenderer,
    bool? isSpeaker,
  }) {
    return Renderer(
      streamId: streamId,
      name: name ?? this.name,
      videoRenderer: videoRenderer ?? this.videoRenderer,
      isSpeaker: isSpeaker ?? this.isSpeaker,
    );
  }

  @override
  List<Object?> get props => [
        streamId,
        name,
        videoRenderer,
        isSpeaker,
      ];

  @override
  bool? get stringify => true;
}
