import 'package:chat_app_flutter/app.dart';
import 'package:chat_app_flutter/core/dependencies/init_dependencies.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_view/message_view_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_system_handle/message_system_handle_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_user_handle/message_user_handle_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load file .env
  await dotenv.load(fileName: '.env');

  // cấu hình cây phụ thuộc
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<MessageViewBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<MessageUserHandleBloc>(),
      ),
      BlocProvider(
        create: (_) => MessageHandleCubit(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<MessageSystemHandleBloc>(),
      ),
    ],
    child: const App(),
  ));
}
