import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/constants/message_event_enum.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_system_handle/message_system_handle_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HandleMessageEvent {
  final Socket _socket;

  HandleMessageEvent({
    required Socket socket,
  }) : _socket = socket;

  void onReceiveNewMessage(BuildContext context) {
    _socket.on(MessageEventEnum.NEW, _handleReceiveNewMessage(context));
  }

  void offReceiveNewMessage(BuildContext context) {
    _socket.off(MessageEventEnum.NEW, _handleReceiveNewMessage(context));
  }

  dynamic _handleReceiveNewMessage(BuildContext context) {
    return (data) {
      Message message = Message.fromJson(data);
      final chatId = context.read<MessageHandleCubit>().state.chatId;
      if (chatId == message.chatId) {
        context.read<MessageSystemHandleBloc>().add(
              ReceiveNewMessageEvent(
                message: message,
              ),
            );
      }
    };
  }
}
