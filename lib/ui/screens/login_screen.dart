import 'package:apple_shop/bloc/authentication/bloc/auth_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                      width: 100.w,
                      height: 100.h,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'اپل شاپ',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 24.sp,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Container(
                  padding: EdgeInsets.all(20.r),
                  margin: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameTextController,
                        decoration: InputDecoration(
                          labelText: 'نام کاربری',
                          labelStyle: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18.sp,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.r),
                            ),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.r),
                            ),
                            borderSide: const BorderSide(
                              color: MyColors.myBlue,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        controller: _passwordTextController,
                        decoration: InputDecoration(
                          labelText: 'رمز عبور',
                          labelStyle: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18.sp,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.r),
                            ),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.r),
                            ),
                            borderSide: const BorderSide(
                              color: MyColors.myBlue,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
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
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                maximumSize: Size(200.w, 48.h),
                              ),
                              child: Text(
                                'ورود به حساب کاربری',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 16.sp,
                                ),
                              ),
                            );
                          } else if (state is AuthLoading) {
                            return const CircularProgressIndicator(
                              color: MyColors.myBlue,
                            );
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
