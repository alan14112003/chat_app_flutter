class VideoCallSoundEnum {
  static const _prevPath = 'sounds/video_call_';
  static const _endPath = '.mp3';
  final String path;
  const VideoCallSoundEnum._(this.path);

  static const VideoCallSoundEnum notConnect = VideoCallSoundEnum._(
      '${VideoCallSoundEnum._prevPath}not_connected${VideoCallSoundEnum._endPath}');
  static const VideoCallSoundEnum request = VideoCallSoundEnum._(
      '${VideoCallSoundEnum._prevPath}request${VideoCallSoundEnum._endPath}');
  static const VideoCallSoundEnum notify1 = VideoCallSoundEnum._(
      '${VideoCallSoundEnum._prevPath}notify_1${VideoCallSoundEnum._endPath}');
}
