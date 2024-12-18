part of 'video_call_user_handle_bloc.dart';

sealed class VideoCallUserHandleState extends Equatable {
  const VideoCallUserHandleState();

  @override
  List<Object> get props => [];
}

final class VideoCallUserHandleInitial extends VideoCallUserHandleState {}

final class VideoCallUserHandleSuccess extends VideoCallUserHandleState {
  final String message;

  const VideoCallUserHandleSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class JoinVideoCallSuccess extends VideoCallUserHandleState {
  final int videoCallState;

  const JoinVideoCallSuccess({
    required this.videoCallState,
  });

  @override
  List<Object> get props => [videoCallState];
}

final class GetUserByIdSuccess extends VideoCallUserHandleState {
  final User user;

  const GetUserByIdSuccess({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
