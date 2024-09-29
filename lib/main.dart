import 'package:chat_app_flutter/app.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_bloc.dart';
import 'package:chat_app_flutter/init_dependencies.dart';
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
        create: (_) => serviceLocator<MessageBloc>(),
      ),
    ],
    child: const App(),
  ));
}
