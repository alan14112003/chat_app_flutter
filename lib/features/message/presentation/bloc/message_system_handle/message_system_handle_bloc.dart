import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/receive_new_message.dart';
import 'package:chat_app_flutter/features/message/domain/usecases/receive_pin_message.dart';
import 'package:equatable/equatable.dart';

part 'message_system_handle_event.dart';
part 'message_system_handle_state.dart';

class MessageSystemHandleBloc
    extends Bloc<MessageSystemHandleEvent, MessageSystemHandleState> {
  final ReceiveNewMessage _receiveNewMessage;
  final ReceivePinMessage _receivePinMessage;

  MessageSystemHandleBloc({
    required ReceiveNewMessage receiveNewMessage,
    required ReceivePinMessage receivePinMessage,
  })  : _receiveNewMessage = receiveNewMessage,
        _receivePinMessage = receivePinMessage,
        super(MessageSystemHandleInitial()) {
    on<ReceiveNewMessageEvent>(_onReceiveNewMessage);
    on<ReceivePinMessageEvent>(_onReceivePinMessage);
  }

  FutureOr<void> _onReceiveNewMessage(
    ReceiveNewMessageEvent event,
    Emitter<MessageSystemHandleState> emit,
  ) async {
    final res = await _receiveNewMessage.call(
      ReceiveNewMessageParam(message: event.message),
    );

    res.fold(
      (error) => emit(MessageSystemHandleFailure(error.message)),
      (messages) => emit(ReceiveNewMessageSuccess(messages)),
    );
  }

  FutureOr<void> _onReceivePinMessage(
    ReceivePinMessageEvent event,
    Emitter<MessageSystemHandleState> emit,
  ) async {
    final res = await _receivePinMessage.call(
      ReceivePinMessageParam(
        message: event.message,
      ),
    );

    res.fold(
      (error) => emit(MessageSystemHandleFailure(error.message)),
      (messages) => emit(ReceivePinMessageSuccess(messages)),
    );
  }
}
