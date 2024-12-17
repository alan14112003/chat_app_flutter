import 'package:chat_app_flutter/core/common/models/renderer.dart';
import 'package:chat_app_flutter/core/utils/auth_global_utils.dart';
import 'package:chat_app_flutter/features/video_call/presentation/cubit/video_call_handler/video_call_handle_cubit.dart';
import 'package:chat_app_flutter/features/video_call/presentation/widgets/actions_handler/actions_handler.dart';
import 'package:chat_app_flutter/features/video_call/presentation/widgets/videos_container/videos_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ion/flutter_ion.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCallScreen extends StatefulWidget {
  final String roomId;
  static route(String roomId) => MaterialPageRoute(
        builder: (context) => VideoCallScreen(
          roomId: roomId,
        ),
      );
  const VideoCallScreen({super.key, required this.roomId});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final Connector _connector = Connector(dotenv.env['SFU_URL']!);
  final List<Renderer> _remoteRenderers = <Renderer>[];
  Renderer? _localRenderer;
  late LocalStream _localStream;
  late RTC _rtc;

  int _getRemoteRendererIndex(streamId) {
    final rendererExistsIndex = _remoteRenderers.indexWhere(
      (renderer) => renderer.streamId == streamId,
    );

    return rendererExistsIndex;
  }

  void _addRendererByTrackEvent(TrackEvent event) {
    final rendererIndex = _getRemoteRendererIndex(event.tracks[0].stream_id);

    // Lấy `Renderer` nếu có hoặc tạo mới
    final renderer = rendererIndex != -1
        ? _remoteRenderers[rendererIndex]
        : Renderer(
            streamId: event.tracks[0].stream_id,
            name: '',
            isSpeaker: false,
          );

    // Cập nhật thông tin `name`
    final updatedRenderer = renderer.copyWith(name: event.uid);
    if (rendererIndex != -1) {
      // Cập nhật phần tử tại vị trí tìm thấy
      _remoteRenderers[rendererIndex] = updatedRenderer;
    } else {
      // Thêm mới nếu chưa tồn tại
      _remoteRenderers.add(updatedRenderer);

      if (_remoteRenderers.length > 2) {
        if (_localRenderer != null) {
          final checkLocalRendererExist = _remoteRenderers.any(
            (renderer) => renderer.streamId == _localRenderer!.streamId,
          );

          if (!checkLocalRendererExist) {
            _remoteRenderers.insert(0, _localRenderer!);
            context.read<VideoCallHandleCubit>().toggleShowLocalRenderer(false);
          }
        }
      }
    }

    context.read<VideoCallHandleCubit>().setRemoteRenderers(
      [..._remoteRenderers],
    );
  }

  void _updateRemoteRendererByRemoteStream(RemoteStream remoteStream) async {
    final rendererIndex = _getRemoteRendererIndex(remoteStream.id);

    final renderer = rendererIndex != -1
        ? _remoteRenderers[rendererIndex]
        : Renderer(
            streamId: remoteStream.id,
            name: '',
            isSpeaker: false,
          );

    final videoRenderer = RTCVideoRenderer();
    await videoRenderer.initialize();
    videoRenderer.srcObject = remoteStream.stream;

    final updatedRenderer = renderer.copyWith(
      videoRenderer: videoRenderer,
    );

    if (rendererIndex == -1) {
      // Thêm mới nếu chưa tồn tại
      _remoteRenderers.add(updatedRenderer);
    } else {
      // Cập nhật phần tử tại vị trí tìm thấy
      _remoteRenderers[rendererIndex] = updatedRenderer;
    }

    setState(() {
      context.read<VideoCallHandleCubit>().setRemoteRenderers(
        [..._remoteRenderers],
      );
    });
  }

  void removeRemoteRenderer(TrackEvent event) {
    final rendererIdx = _remoteRenderers.indexWhere(
      (renderer) => renderer.streamId == event.tracks[0].stream_id,
    );
    if (rendererIdx != -1) {
      _remoteRenderers[rendererIdx].videoRenderer!.dispose();
      _remoteRenderers.removeAt(rendererIdx);
    }

    if (_remoteRenderers.length < 4) {
      _remoteRenderers.removeWhere(
        (renderer) => renderer.streamId == _localRenderer?.streamId,
      );

      context.read<VideoCallHandleCubit>().toggleShowLocalRenderer(true);
    }

    context.read<VideoCallHandleCubit>().setRemoteRenderers(
      [..._remoteRenderers],
    );
  }

  void _updateSpeackerRenderers(Map<String, dynamic> list) {
    Set<dynamic> speakers = list['params'].toSet();

    for (var i = 0; i < _remoteRenderers.length; i++) {
      _remoteRenderers[i] = _remoteRenderers[i].copyWith(
        isSpeaker: speakers.contains(
          _remoteRenderers[i].streamId,
        ),
      );
    }

    context.read<VideoCallHandleCubit>().setRemoteRenderers(
      [..._remoteRenderers],
    );
  }

  @override
  void initState() {
    super.initState();
    connectWebRTC();
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<VideoCallHandleCubit>().cleanData();
  }

  @override
  void dispose() {
    cleanUp();
    super.dispose();
  }

  void cleanUp() async {
    await _localRenderer!.videoRenderer!.dispose();

    for (var renderer in _remoteRenderers) {
      renderer.videoRenderer!.srcObject?.getTracks().forEach((track) async {
        await track.stop();
      });

      await renderer.videoRenderer!.dispose();
    }

    _localStream.stream.getTracks().forEach(
      (element) async {
        await element.stop();
      },
    );

    _rtc.close();
  }

  void connectWebRTC() async {
    await Helper.setAndroidAudioConfiguration(
      AndroidAudioConfiguration.communication,
    );
    final config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'}
      ],
    };
    _rtc = RTC(_connector, cfg: Map<String, Object>.from(config));

    _rtc.onspeaker = (Map<String, dynamic> list) {
      _updateSpeackerRenderers(list);
    };

    _rtc.ontrack = (track, RemoteStream remoteStream) async {
      if (track.kind == 'video') {
        _updateRemoteRendererByRemoteStream(remoteStream);
      }
    };

    _rtc.ontrackevent = (TrackEvent event) {
      switch (event.state) {
        case TrackState.ADD:
          _addRendererByTrackEvent(event);
          break;
        case TrackState.REMOVE:
          removeRemoteRenderer(event);
          break;
        default:
      }
    };

    await _rtc.connect();

    await _rtc.join(
      widget.roomId,
      AuthGlobalUtils.getAuth().id ?? '',
      JoinConfig(),
    );

    final localVideoRenderer = RTCVideoRenderer();
    await localVideoRenderer.initialize();

    // publish LocalStream
    final localStream = await LocalStream.getUserMedia(
      constraints: Constraints.defaults,
    );

    _localStream = localStream;

    localVideoRenderer.srcObject = localStream.stream;

    _localRenderer = Renderer(
      streamId: localStream.stream.id,
      name: 'Bạn',
      videoRenderer: localVideoRenderer,
      isSpeaker: false,
    );

    await _rtc.publish(localStream);

    setState(() {
      context.read<VideoCallHandleCubit>().setLocalStream(localStream);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(50, 0, 0, 0),
        body: Stack(
          children: [
            VideosContainer(),
            Positioned(
              bottom: 50,
              right: 10,
              width: 120,
              height: 160,
              child: BlocSelector<VideoCallHandleCubit, VideoCallHandleState,
                  bool>(
                selector: (state) {
                  return state.showLocalRenderer;
                },
                builder: (context, showLocalRenderer) {
                  if (!showLocalRenderer) {
                    return SizedBox();
                  }
                  return Center(
                    child: _localRenderer?.videoRenderer == null
                        ? CircularProgressIndicator()
                        : RTCVideoView(
                            _localRenderer!.videoRenderer!,
                          ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: ActionsHandler(),
            )
          ],
        ));
  }
}
