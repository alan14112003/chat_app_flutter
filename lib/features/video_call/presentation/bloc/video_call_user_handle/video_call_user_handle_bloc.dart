import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/features/video_call/domain/usecases/join_video_call.dart';
import 'package:chat_app_flutter/features/video_call/domain/usecases/refuse_video_call.dart';
import 'package:equatable/equatable.dart';

part 'video_call_user_handle_event.dart';
part 'video_call_user_handle_state.dart';

class VideoCallUserHandleBloc
    extends Bloc<VideoCallUserHandleEvent, VideoCallUserHandleState> {
  final JoinVideoCall _joinVideoCall;
  final RefuseVideoCall _refuseVideoCall;
  VideoCallUserHandleBloc({
    required JoinVideoCall joinVideoCall,
    required RefuseVideoCall refuseVideoCall,
  })  : _joinVideoCall = joinVideoCall,
        _refuseVideoCall = refuseVideoCall,
        super(VideoCallUserHandleInitial()) {
    on<JoinVideoCallEvent>(_onJoinVideoCall);
    on<RefuseVideoCallEvent>(_onrefuseVideoCall);
  }

  FutureOr<void> _onJoinVideoCall(
    JoinVideoCallEvent event,
    Emitter<VideoCallUserHandleState> emit,
  ) async {
    await _joinVideoCall.call(
      JoinVideoCallParams(chatId: event.chatId),
    );
  }

  FutureOr<void> _onrefuseVideoCall(RefuseVideoCallEvent event,
      Emitter<VideoCallUserHandleState> emit) async {
    await _refuseVideoCall.call(
      RefuseVideoCallParams(chatId: event.chatId),
    );
  }
}
