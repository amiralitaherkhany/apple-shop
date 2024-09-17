import 'package:apple_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/ui/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _usernameTextController =
      TextEditingController(text: 'amiralitaherkhany');
  final TextEditingController _passwordTextController =
      TextEditingController(text: 'Amir0200820621');
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: MyColors.myBlue,
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2 - 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon_application.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'اپل شاپ',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameTextController,
                        decoration: const InputDecoration(
                          labelText: 'نام کاربری',
                          labelStyle: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                              color: MyColors.myBlue,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _passwordTextController,
                        decoration: const InputDecoration(
                          labelText: 'رمز عبور',
                          labelStyle: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                              color: MyColors.myBlue,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthInitial) {
                            return ElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(AuthLoginRequest(
                                    username: _usernameTextController.text,
                                    password: _passwordTextController.text));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.myBlue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                maximumSize: const Size(200, 48),
                              ),
                              child: const Text(
                                'ورود به حساب کاربری',
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
                                return Text(l);
                              },
                              (r) {
                                return Text(r);
                              },
                            );
                          } else {
                            return const Text('خطای نامشخص');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
