import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/auth/presentation/screens/register_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app_flutter/features/auth/presentation/cubit/auth_login/auth_login_cubit.dart';
import 'package:chat_app_flutter/features/auth/presentation/widgets/login_btn.dart';
import 'package:chat_app_flutter/features/auth/presentation/widgets/login_input_field.dart';

class LoginScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => LoginScreen(),
      );
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            showSnackBar(context, 'Đăng nhập thành công!');
            // Điều hướng khi đăng nhập thành công
            Navigator.push(context, ChatScreen.route());
            return;
          }
          if (state is AuthFailure) {
            showSnackBar(context, state.error);
            return;
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 80.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'ĐĂNG NHẬP',
                    style: TextStyle(
                      color: Color.fromRGBO(27, 114, 192, 1.0),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<AuthLoginCubit, AuthLoginState>(
                    builder: (context, state) {
                      return LoginInputField(
                        hintText: 'Email',
                        obscureText: false,
                        onChanged: (value) {
                          context.read<AuthLoginCubit>().emailChanged(value);
                        },
                        errorText: state.isSubmitted && !state.isValidEmail
                            ? 'Email không hợp lệ'
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AuthLoginCubit, AuthLoginState>(
                    builder: (context, state) {
                      return LoginInputField(
                        hintText: 'Mật khẩu',
                        obscureText: true,
                        onChanged: (value) {
                          context.read<AuthLoginCubit>().passwordChanged(value);
                        },
                        errorText: state.isSubmitted && !state.isValidPassword
                            ? 'Mật khẩu phải tối thiểu 6 ký tự'
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  LoginBtn(
                    onPressed: () {
                      context.read<AuthLoginCubit>().toggleIsSubmitted(true);
                      final loginState = context.read<AuthLoginCubit>().state;

                      if (!(loginState.isValidEmail &&
                          loginState.isValidPassword)) {
                        return;
                      }

                      context.read<AuthBloc>().add(
                            LoginButtonPressed(
                              email: loginState.email,
                              password: loginState.password,
                            ),
                          );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, RegisterScreen.route());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Color.fromRGBO(76, 77, 79, 1),
                      foregroundColor: Color.fromRGBO(211, 228, 255, 1.0),
                    ),
                    child: Text('Register'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
