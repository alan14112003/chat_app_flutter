import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app_flutter/features/auth/presentation/cubit/auth_active_email/auth_active_email_cubit.dart';
import 'package:chat_app_flutter/features/auth/presentation/cubit/auth_register/auth_register_cubit.dart';
import 'package:chat_app_flutter/features/auth/presentation/screens/active_email_screen.dart';
import 'package:chat_app_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:chat_app_flutter/features/auth/presentation/widgets/login_btn.dart';
import 'package:chat_app_flutter/features/auth/presentation/widgets/login_input_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      );

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterSuccess) {
            showSnackBar(context, 'Đăng ký thành công!');

            final email = context.read<AuthRegisterCubit>().state.email;
            context.read<AuthActiveEmailCubit>().emailChanged(email);

            Navigator.push(context, ActiveEmailScreen.route());
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
                    'ĐĂNG KÝ',
                    style: TextStyle(
                      color: Color.fromRGBO(27, 114, 192, 1.0),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<AuthRegisterCubit, AuthRegisterState>(
                    builder: (context, state) {
                      return LoginInputField(
                        hintText: 'Họ',
                        obscureText: false,
                        onChanged: (value) {
                          context
                              .read<AuthRegisterCubit>()
                              .firstNameChanged(value);
                        },
                        errorText: state.isSubmitted && !state.isValidFirstName
                            ? 'Họ không được để trống'
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AuthRegisterCubit, AuthRegisterState>(
                    builder: (context, state) {
                      return LoginInputField(
                        hintText: 'Tên',
                        obscureText: false,
                        onChanged: (value) {
                          context
                              .read<AuthRegisterCubit>()
                              .lastNameChanged(value);
                        },
                        errorText: state.isSubmitted && !state.isValidLastName
                            ? 'Tên không được để trống'
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AuthRegisterCubit, AuthRegisterState>(
                    builder: (context, state) {
                      return LoginInputField(
                        hintText: 'Email',
                        obscureText: false,
                        onChanged: (value) {
                          context.read<AuthRegisterCubit>().emailChanged(value);
                        },
                        errorText: state.isSubmitted && !state.isValidEmail
                            ? 'Email không hợp lệ'
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AuthRegisterCubit, AuthRegisterState>(
                    builder: (context, state) {
                      return LoginInputField(
                        hintText: 'Mật khẩu',
                        obscureText: true,
                        onChanged: (value) {
                          context
                              .read<AuthRegisterCubit>()
                              .passwordChanged(value);
                        },
                        errorText: state.isSubmitted && !state.isValidPassword
                            ? 'Mật khẩu phải tối thiểu 3 ký tự'
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AuthRegisterCubit, AuthRegisterState>(
                    builder: (context, state) {
                      return LoginInputField(
                        hintText: 'Nhập lại mật khẩu',
                        obscureText: true,
                        onChanged: (value) {
                          context
                              .read<AuthRegisterCubit>()
                              .confirmPasswordChanged(value);
                        },
                        errorText:
                            state.isSubmitted && !state.isValidConfirmPassword
                                ? 'Mật khẩu nhập lại không khớp'
                                : null,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AuthRegisterCubit, AuthRegisterState>(
                    builder: (context, state) {
                      return DropdownButtonFormField<int>(
                        decoration: const InputDecoration(
                          labelText: 'Giới tính',
                        ),
                        value: state.gender,
                        items: const [
                          DropdownMenuItem(value: 0, child: Text('Bí mật')),
                          DropdownMenuItem(value: 1, child: Text('Nữ')),
                          DropdownMenuItem(value: 2, child: Text('Nam')),
                          DropdownMenuItem(value: 3, child: Text('LGBT')),
                        ],
                        onChanged: (value) {
                          context
                              .read<AuthRegisterCubit>()
                              .genderChanged(value ?? 0);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  LoginBtn(
                    onPressed: () {
                      context.read<AuthRegisterCubit>().toggleIsSubmitted(true);
                      final registerState =
                          context.read<AuthRegisterCubit>().state;

                      if (!(registerState.isValidFirstName &&
                          registerState.isValidLastName &&
                          registerState.isValidEmail &&
                          registerState.isValidPassword &&
                          registerState.isValidConfirmPassword)) {
                        return;
                      }

                      context.read<AuthBloc>().add(
                            RegisterButtonPressed(
                              firstName: registerState.firstName,
                              lastName: registerState.lastName,
                              email: registerState.email,
                              password: registerState.password,
                              gender: registerState.gender,
                            ),
                          );
                    },
                    name: 'Đăng ký',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Bạn đã có tài khoản? ',
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Đăng nhập',
                          style: const TextStyle(color: Colors.red),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, LoginScreen.route());
                            },
                        ),
                      ],
                    ),
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
