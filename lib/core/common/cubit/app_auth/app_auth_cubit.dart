import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/common/usecase/app_auth/get_user_logged_in.dart';
import 'package:chat_app_flutter/core/common/usecase/app_auth/set_user_logged_in.dart';
import 'package:chat_app_flutter/core/common/usecase/app_auth/set_user_logged_out.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'app_auth_state.dart';

class AppAuthCubit extends Cubit<AppAuthState> {
  final SetUserLoggedIn _setUserLoggedIn;
  final GetUserLoggedIn _getUserLoggedIn;
  final SetUserLoggedOut _setUserLoggedOut;
  final Socket _socket;

  AppAuthCubit({
    required SetUserLoggedIn setUserLoggedIn,
    required GetUserLoggedIn getUserLoggedIn,
    required SetUserLoggedOut setUserLoggedOut,
    required Socket socket,
  })  : _setUserLoggedIn = setUserLoggedIn,
        _getUserLoggedIn = getUserLoggedIn,
        _setUserLoggedOut = setUserLoggedOut,
        _socket = socket,
        super(AuthInitial());

  Future<void> setUserLoggedIn(User user) async {
    await _setUserLoggedIn(user);
    _joinRoomSocket(user);
    emit(Authenticated(user: user));
  }

  Future<void> checkUserLoggedIn() async {
    final result = await _getUserLoggedIn.call(NoParams());
    result.fold(
      (failure) => emit(Unauthenticated()),
      (user) {
        if (user != null) {
          _joinRoomSocket(user);
          emit(Authenticated(user: user));
          return;
        }
        emit(Unauthenticated());
      },
    );
  }

  Future<void> logout() async {
    final response = await _setUserLoggedOut.call(NoParams());

    final user = response.getOrElse(
      (l) {
        return;
      },
    );
    if (user != null) {
      _leaveRoomSocket(user);
    }
    emit(Unauthenticated());
  }

  void _joinRoomSocket(User user) {
    _socket.emit('join', user.id);
  }

  void _leaveRoomSocket(User user) {
    _socket.emit('leave', user.id);
  }
}
