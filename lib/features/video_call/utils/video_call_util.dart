import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app_flutter/core/constants/video_call_sound_enum.dart';

class VideoCallUtil {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _isPlaying = false;
  static String _path = '';
  static double _volume = 0.5;

  static void _startNotificationSound(isAutoPlay) async {
    _audioPlayer.onPlayerComplete.listen((event) {
      if (_isPlaying) {
        _playNotificationSound(); // Phát lại nếu trong trạng thái đang phát
      }
    });

    _isPlaying = isAutoPlay;
    _playNotificationSound(); // Bắt đầu phát âm thanh
  }

  static Future<void> _playNotificationSound() async {
    try {
      print('_volume $_volume');
      await _audioPlayer.play(
        AssetSource(
          _path,
        ),
        volume: _volume, // Điều chỉnh âm lượng (0.0 - 1.0)
      );
    } catch (e) {
      print('Không thể phát âm thanh: $e');
    }
  }

  static void stopNotificationSound() {
    _isPlaying = false;
    _audioPlayer.stop(); // Dừng phát âm thanh
  }

  static Future<void> requestCallSoundStart() async {
    _volume = 0.5;
    _path = VideoCallSoundEnum.request.path;
    _startNotificationSound(true);
  }

  static Future<void> terminateCallSoundStart() async {
    _volume = 1;
    _path = VideoCallSoundEnum.notConnect.path;
    _startNotificationSound(false);
  }

  static Future<void> notifyCallSoundStart() async {
    _volume = 1;
    _path = VideoCallSoundEnum.notify1.path;
    _startNotificationSound(true);
  }
}
