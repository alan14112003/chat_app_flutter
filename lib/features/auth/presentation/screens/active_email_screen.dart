import 'package:chat_app_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:chat_app_flutter/features/auth/presentation/widgets/active_email_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app_flutter/features/auth/presentation/cubit/auth_active_email/auth_active_email_cubit.dart';
import 'package:chat_app_flutter/features/auth/presentation/widgets/login_btn.dart';

class ActiveEmailScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => ActiveEmailScreen(),
      );

  const ActiveEmailScreen({super.key});

  @override
  State<ActiveEmailScreen> createState() => _ActiveEmailScreenState();
}

class _ActiveEmailScreenState extends State<ActiveEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ActiveEmailSuccess) {
            showSnackBar(context, 'Xác thực thành công!');
            // Điều hướng khi đăng nhập thành công
            Navigator.push(context, LoginScreen.route());
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
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 80.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'KÍCH HOẠT TÀI KHOẢN',
                  style: TextStyle(
                    color: Color.fromRGBO(27, 114, 192, 1.0),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                BlocBuilder<AuthActiveEmailCubit, AuthActiveEmailState>(
                  builder: (context, state) {
                    return ActiveEmailInput(
                      hintText: 'Mã xác thực',
                      obscureText: false,
                      initialValue: state.code, // Truyền giá trị hiện tại vào
                      onChanged: (value) {
                        context.read<AuthActiveEmailCubit>().codeChanged(value);
                      },
                      errorText: state.isSubmitted && !state.isValidCode
                          ? 'Mã xác thực không được để trống'
                          : null,
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<AuthActiveEmailCubit, AuthActiveEmailState>(
                  builder: (context, state) {
                    return ActiveEmailInput(
                      hintText: 'Email',
                      obscureText: false,
                      initialValue: state.email, // Truyền giá trị hiện tại vào
                      onChanged: (value) {
                        context
                            .read<AuthActiveEmailCubit>()
                            .emailChanged(value);
                      },
                      errorText: state.isSubmitted && !state.isValidEmail
                          ? 'Email không hợp lệ'
                          : null,
                    );
                  },
                ),
                const SizedBox(height: 30),
                LoginBtn(
                  onPressed: () {
                    context
                        .read<AuthActiveEmailCubit>()
                        .toggleIsSubmitted(true);
                    final activeEmailState =
                        context.read<AuthActiveEmailCubit>().state;

                    if (!(activeEmailState.isValidCode &&
                        activeEmailState.isValidEmail)) {
                      return;
                    }

                    context.read<AuthBloc>().add(
                          ActiveEmailEvent(
                            code: activeEmailState.code,
                            email: activeEmailState.email,
                          ),
                        );
                  },
                  name: 'Xác nhận',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
