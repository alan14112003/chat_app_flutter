// ignore_for_file: library_prefixes

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket _socket;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal() {
    _socket = IO.io(
      dotenv.env['URL']!,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableReconnection()
          .build(),
    );
    // _socket.connect();
  }

  IO.Socket get socket => _socket;
}
