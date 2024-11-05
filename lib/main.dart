import 'package:chat_app_flutter/app.dart';
import 'package:chat_app_flutter/core/common/cubit/app_auth/app_auth_cubit.dart';
import 'package:chat_app_flutter/core/common/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:chat_app_flutter/core/dependencies/init_dependencies.dart';
import 'package:chat_app_flutter/features/auth/presentation/cubit/auth_active_email/auth_active_email_cubit.dart';
import 'package:chat_app_flutter/features/auth/presentation/cubit/auth_register/auth_register_cubit.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/add_group/add_group_bloc.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/chat_view/chat_view_bloc.dart';
import 'package:chat_app_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app_flutter/features/auth/presentation/cubit/auth_login/auth_login_cubit.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/group_create_view/group_create_view_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_user_handle_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_view_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/chat_info_view/chat_info_view_bloc.dart';
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
      // BlocProvider cho các Bloc hiện tại của bạn
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

      // BlocProvider cho FriendBloc (thêm vào đây)
      BlocProvider(
        create: (_) => serviceLocator<FriendViewBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<FriendUserHandleBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<ChatInfoViewBloc>(),
      ),

      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthLoginCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AppAuthCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthRegisterCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthActiveEmailCubit>(),
      ),

      // BlocProvider cho Chat (PTH)
      BlocProvider(
        create: (_) => serviceLocator<ChatViewBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<GroupCreateViewBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AddGroupBloc>(),
      ),

      BlocProvider(
        create: (_) => serviceLocator<BottomNavigationCubit>(),
      )
    ],
    child: const App(),
  ));
}
