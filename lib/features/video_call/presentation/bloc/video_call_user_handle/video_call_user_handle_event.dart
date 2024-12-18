part of 'video_call_user_handle_bloc.dart';

sealed class VideoCallUserHandleEvent extends Equatable {
  const VideoCallUserHandleEvent();

  @override
  List<Object> get props => [];
}

class JoinVideoCallEvent extends VideoCallUserHandleEvent {
  final String chatId;

  const JoinVideoCallEvent({
    required this.chatId,
  });
}

class RefuseVideoCallEvent extends VideoCallUserHandleEvent {
  final String chatId;

  const RefuseVideoCallEvent({
    required this.chatId,
  });
}

class CloseVideoCallEvent extends VideoCallUserHandleEvent {
  final String chatId;

  const CloseVideoCallEvent({
    required this.chatId,
  });
}

class GetUserByIdEvent extends VideoCallUserHandleEvent {
  final String userId;

  const GetUserByIdEvent({
    required this.userId,
  });
}
