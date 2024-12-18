import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/features/video_call/domain/usecases/close_video_call.dart';
import 'package:chat_app_flutter/features/video_call/domain/usecases/get_user_by_id_usecase.dart';
import 'package:chat_app_flutter/features/video_call/domain/usecases/join_video_call.dart';
import 'package:chat_app_flutter/features/video_call/domain/usecases/refuse_video_call.dart';
import 'package:equatable/equatable.dart';

part 'video_call_user_handle_event.dart';
part 'video_call_user_handle_state.dart';

class VideoCallUserHandleBloc
    extends Bloc<VideoCallUserHandleEvent, VideoCallUserHandleState> {
  final JoinVideoCall _joinVideoCall;
  final RefuseVideoCall _refuseVideoCall;
  final CloseVideoCall _closeVideoCall;
  final GetUserByIdUsecase _getUserByIdUsecase;

  VideoCallUserHandleBloc({
    required JoinVideoCall joinVideoCall,
    required RefuseVideoCall refuseVideoCall,
    required CloseVideoCall closeVideoCall,
    required GetUserByIdUsecase getUserByIdUsecase,
  })  : _joinVideoCall = joinVideoCall,
        _refuseVideoCall = refuseVideoCall,
        _closeVideoCall = closeVideoCall,
        _getUserByIdUsecase = getUserByIdUsecase,
        super(VideoCallUserHandleInitial()) {
    on<JoinVideoCallEvent>(_onJoinVideoCall);
    on<RefuseVideoCallEvent>(_onRefuseVideoCall);
    on<CloseVideoCallEvent>(_onCloseVideoCall);
    on<GetUserByIdEvent>(_onGetUserById);
  }

  FutureOr<void> _onJoinVideoCall(
    JoinVideoCallEvent event,
    Emitter<VideoCallUserHandleState> emit,
  ) async {
    emit(VideoCallUserHandleInitial());
    final res = await _joinVideoCall.call(
      JoinVideoCallParams(chatId: event.chatId),
    );

    res.fold((l) {}, (videoCallState) {
      emit(JoinVideoCallSuccess(videoCallState: videoCallState));
    });
  }

  FutureOr<void> _onRefuseVideoCall(
    RefuseVideoCallEvent event,
    Emitter<VideoCallUserHandleState> emit,
  ) async {
    await _refuseVideoCall.call(
      RefuseVideoCallParams(chatId: event.chatId),
    );
  }

  FutureOr<void> _onCloseVideoCall(
    CloseVideoCallEvent event,
    Emitter<VideoCallUserHandleState> emit,
  ) async {
    await _closeVideoCall.call(
      CloseVideoCallParams(chatId: event.chatId),
    );
  }

  FutureOr<void> _onGetUserById(
    GetUserByIdEvent event,
    Emitter<VideoCallUserHandleState> emit,
  ) async {
    emit(VideoCallUserHandleInitial());
    final res = await _getUserByIdUsecase.call(
      GetUserByIdUsecaseParams(userId: event.userId),
    );

    res.fold(
      (l) {},
      (user) {
        emit(
          GetUserByIdSuccess(user: user),
        );
      },
    );
  }
}
