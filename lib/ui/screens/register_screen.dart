import 'package:apple_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/ui/screens/login_screen.dart';
import 'package:apple_shop/ui/screens/main_wrapper.dart';
import 'package:apple_shop/ui/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _passwordConfirmTextController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => locator.get(),
      child: viewContainer(context),
    );
  }

  Directionality viewContainer(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/register.png',
                      width: 250,
                      height: 250,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'نام کاربری:',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          // onTapOutside: (event) {
                          //   FocusManager.instance.primaryFocus?.unfocus();
                          // },
                          controller: _usernameTextController,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              gapPadding: 0,
                              borderSide: BorderSide(
                                width: 2,
                                color: MyColors.myBlue,
                              ),
                            ),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'رمز عبور:',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          // onTapOutside: (event) {
                          //   FocusManager.instance.primaryFocus?.unfocus();
                          // },
                          controller: _passwordTextController,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              gapPadding: 0,
                              borderSide: BorderSide(
                                width: 2,
                                color: MyColors.myBlue,
                              ),
                            ),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          ' تکرار رمز عبور:',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          // onTapOutside: (event) {
                          //   FocusManager.instance.primaryFocus?.unfocus();
                          // },
                          controller: _passwordConfirmTextController,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              gapPadding: 0,
                              borderSide: BorderSide(
                                width: 2,
                                color: MyColors.myBlue,
                              ),
                            ),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthResponse) {
                          state.response.fold(
                            (l) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    l,
                                    style: const TextStyle(
                                      fontFamily: 'SB',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            },
                            (r) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const MainWrapper(),
                                ),
                              );
                            },
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthInitial) {
                          return ElevatedButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              context.read<AuthBloc>().add(
                                    AuthRegisterRequest(
                                      username: _usernameTextController.text,
                                      password: _passwordTextController.text,
                                      passwordConfirm:
                                          _passwordConfirmTextController.text,
                                    ),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.myBlue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fixedSize: const Size(250, 48),
                            ),
                            child: const Text(
                              'ثبت نام',
                              style: TextStyle(
                                fontFamily: 'SB',
                                fontSize: 16,
                              ),
                            ),
                          );
                        } else if (state is AuthLoading) {
                          return const CustomLoadingWidget();
                        } else if (state is AuthResponse) {
                          return state.response.fold(
                            (l) {
                              return ElevatedButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  context.read<AuthBloc>().add(
                                        AuthRegisterRequest(
                                          username:
                                              _usernameTextController.text,
                                          password:
                                              _passwordTextController.text,
                                          passwordConfirm:
                                              _passwordConfirmTextController
                                                  .text,
                                        ),
                                      );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.myBlue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  fixedSize: const Size(250, 48),
                                ),
                                child: const Text(
                                  'ثبت نام',
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                            (r) {
                              return Text(
                                r,
                                style: const TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 16,
                                ),
                              );
                            },
                          );
                        } else {
                          return const Text(
                            'خطای نامشخص',
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: MyColors.myBlue),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'حساب کاربری دارید؟ وارد شوید ',
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
