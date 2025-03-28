import 'package:chat_app_flutter/core/common/cubit/app_auth/app_auth_cubit.dart';
import 'package:chat_app_flutter/core/common/cubit/app_auth/app_auth_state.dart';
import 'package:chat_app_flutter/core/common/cubit/app_lifecycle_impl/app_lifecycle_impl_cubit.dart';
import 'package:chat_app_flutter/core/common/socket/socket_builder.dart';
import 'package:chat_app_flutter/core/dependencies/init_dependencies.dart';
import 'package:chat_app_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/screens/chat_screen.dart';
import 'package:chat_app_flutter/features/message/events/message_event_socket.dart';
import 'package:chat_app_flutter/features/video_call/events/video_call_event_socket.dart';
import 'package:chat_app_flutter/features/video_call/presentation/widgets/listen_video_call_user_handle_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final Socket _socket = serviceLocator<Socket>();

  @override
  void initState() {
    super.initState();

    // Đăng ký lắng nghe trạng thái vòng đời ứng dụng
    WidgetsBinding.instance.addObserver(this);

    // connect socket
    _socket.onConnect((_) {
      print('connect to socket');
    });

    // call check authentication
    context.read<AppAuthCubit>().checkUserLoggedIn();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // In trạng thái hiện tại ra console
    switch (state) {
      case AppLifecycleState.resumed:
        print("Ứng dụng đang hiển thị (resumed).");
        break;
      case AppLifecycleState.inactive:
        print("Ứng dụng đang không hoạt động (inactive).");
        break;
      case AppLifecycleState.paused:
        print("Ứng dụng đang chạy nền (paused).");
        break;
      case AppLifecycleState.detached:
        print("Ứng dụng đã bị đóng hoặc tách khỏi giao diện (detached).");
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        print("Không có state.");
    }

    context.read<AppLifecycleImplCubit>().setState(state);
  }

  @override
  void dispose() {
    // Hủy đăng ký khi không cần lắng nghe nữa
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: serviceLocator<GlobalKey<NavigatorState>>(),
      debugShowCheckedModeBanner: false,
      title: 'Chat app',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: BlocBuilder<AppAuthCubit, AppAuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            // Trạng thái đã đăng nhập, hiển thị màn hình
            return MultiSocketBuilder(
              builders: [
                SocketBuilder(
                  instant: serviceLocator<MessageEventSocket>(),
                ),
                SocketBuilder(
                  instant: serviceLocator<VideoCallEventSocket>(),
                )
              ],
              child: ListenVideoCallUserHandleState(
                child: const ChatScreen(),
              ),
            );
          } else if (state is Unauthenticated) {
            // Trạng thái chưa đăng nhập, hiển thị màn hình Login
            return const LoginScreen();
          }
          // Hiển thị màn hình chờ trong khi kiểm tra trạng thái đăng nhập
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
