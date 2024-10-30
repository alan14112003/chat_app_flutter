import 'package:chat_app_flutter/features/chat/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app_flutter/features/auth/presentation/cubit/auth_login_cubit.dart';
import 'package:chat_app_flutter/features/auth/presentation/widgets/login_btn.dart';
import 'package:chat_app_flutter/features/auth/presentation/widgets/login_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isSubmitted = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đăng nhập thành công!'),
              ),
            );
            // Điều hướng khi đăng nhập thành công
            Navigator.push(context, ChatScreen.route());
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Đăng nhập thất bại!'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 80.0),
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
                        controller: emailController,
                        onChanged: (value) {
                          context.read<AuthLoginCubit>().emailChanged(value);
                        },
                        errorText: isSubmitted && !state.isValidEmail
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
                        controller: passwordController,
                        onChanged: (value) {
                          context.read<AuthLoginCubit>().passwordChanged(value);
                        },
                        errorText: isSubmitted && !state.isValidPassword
                            ? 'Mật khẩu phải tối thiểu 6 ký tự'
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<AuthLoginCubit, AuthLoginState>(
                    builder: (context, state) {
                      return LoginBtn(
                        onPressed: () {
                          setState(() {
                            isSubmitted = true; // Đánh dấu rằng đã nhấn nút
                          });

                          final email = emailController.text;
                          final password = passwordController.text;

                          if (context.read<AuthLoginCubit>().isFormValid()) {
                            context.read<AuthBloc>().add(
                                  LoginButtonPressed(
                                    email: email,
                                    password: password,
                                  ),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Email không hợp lệ hoặc mật khẩu ngắn hơn 6 ký tự',
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
