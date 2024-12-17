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
