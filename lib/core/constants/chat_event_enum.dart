// ignore_for_file: constant_identifier_names

class ChatEventEnum {
  static const _eventName = 'chats';
  static const String VIDEO_CALL_REQUEST = '$_eventName:video_call_request';
  static const String VIDEO_CALL_JOIN = '$_eventName:video_call_join';
  static const String VIDEO_CALL_REFUSE = '$_eventName:video_call_refuse';
  static const String VIDEO_CALL_TERMINATE = '$_eventName:video_call_terminate';
  static const String VIDEO_CALL_CLOSE = '$_eventName:video_call_close';
}
