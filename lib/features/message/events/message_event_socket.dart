import 'package:chat_app_flutter/core/common/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/common/socket/socket_builder.dart';
import 'package:chat_app_flutter/core/constants/message_event_enum.dart';
import 'package:chat_app_flutter/core/constants/navigation_enum.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/chat_view/chat_view_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_system_handle/message_system_handle_bloc.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MessageEventSocket extends SocketListener {
  final Socket _socket;

  MessageEventSocket({
    required Socket socket,
  }) : _socket = socket;

  // receive new message
  void onReceiveNewMessage(BuildContext context) {
    _socket.on(MessageEventEnum.NEW, _handleReceiveNewMessage(context));
  }

  void offReceiveNewMessage(BuildContext context) {
    _socket.off(MessageEventEnum.NEW, _handleReceiveNewMessage(context));
  }

  dynamic _handleReceiveNewMessage(BuildContext context) {
    return (data) {
      Message message = Message.fromJson(data);

      // nếu message của đoạn chat đang mở thì thực hiện thêm nó vào danh sách
      if (HandleMessageUtil.isMessageInActiveChat(context, message)) {
        context.read<MessageSystemHandleBloc>().add(
              ReceiveNewMessageEvent(
                message: message,
              ),
            );
        return;
      }

      final navigationState = context.read<BottomNavigationCubit>().state;
      if (navigationState == NavigationEnum.CHAT) {
        context.read<ChatViewBloc>().add(ReloadAllChatEvent());
        return;
      }
    };
  }

  // receive pin message
  void onReceivePinMessage(BuildContext context) {
    _socket.on(MessageEventEnum.PIN, _handleReceivePinMessage(context));
  }

  void offReceivePinMessage(BuildContext context) {
    _socket.off(MessageEventEnum.PIN, _handleReceivePinMessage(context));
  }

  dynamic _handleReceivePinMessage(BuildContext context) {
    return (data) {
      Message message = Message.fromJson(data);
      // nếu message của đoạn chat đang mở thì thực hiện load lại danh sách
      if (HandleMessageUtil.isMessageInActiveChat(context, message)) {
        context.read<MessageSystemHandleBloc>().add(
              ReceivePinMessageEvent(
                message: message,
              ),
            );
        return;
      }

      final navigationState = context.read<BottomNavigationCubit>().state;
      if (navigationState == NavigationEnum.CHAT) {
        context.read<ChatViewBloc>().add(ReloadAllChatEvent());
        return;
      }
    };
  }

  // receive recall message
  void onReceiveRecallMessage(BuildContext context) {
    _socket.on(MessageEventEnum.RECALL, _handleReceiveRecallMessage(context));
  }

  void offReceiveRecallMessage(BuildContext context) {
    _socket.off(MessageEventEnum.RECALL, _handleReceiveRecallMessage(context));
  }

  dynamic _handleReceiveRecallMessage(BuildContext context) {
    return (data) {
      Message message = Message.fromJson(data);
      // nếu message của đoạn chat đang mở thì thực hiện load lại danh sách
      if (HandleMessageUtil.isMessageInActiveChat(context, message)) {
        context.read<MessageSystemHandleBloc>().add(
              ReceiveRecallMessageEvent(
                message: message,
              ),
            );
        return;
      }

      final navigationState = context.read<BottomNavigationCubit>().state;
      if (navigationState == NavigationEnum.CHAT) {
        context.read<ChatViewBloc>().add(ReloadAllChatEvent());
        return;
      }
    };
  }

  @override
  void initListeners(BuildContext context) {
    onReceiveNewMessage(context);
    onReceivePinMessage(context);
    onReceiveRecallMessage(context);
  }

  @override
  void removeListeners(BuildContext context) {
    offReceiveNewMessage(context);
    offReceivePinMessage(context);
    offReceiveRecallMessage(context);
  }
}
