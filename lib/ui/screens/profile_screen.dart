import 'package:apple_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/main.dart';
import 'package:apple_shop/ui/screens/login_screen.dart';
import 'package:apple_shop/ui/screens/main_wrapper.dart';
import 'package:apple_shop/util/auth_manager.dart';
import 'package:apple_shop/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: Responsive.scaleFromFigma(context, 10),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.scaleFromFigma(context, 44)),
          child: Container(
            width: Responsive.scaleFromFigma(context, 340),
            height: Responsive.scaleFromFigma(context, 46),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Text(
                  'حساب کاربری',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: Responsive.scaleFromFigma(context, 16),
                    color: MyColors.myBlue,
                  ),
                ),
                Positioned(
                  left: Responsive.scaleFromFigma(context, 15),
                  top: Responsive.scaleFromFigma(context, 10),
                  child: Image.asset(
                    'assets/images/icon_apple_blue.png',
                    width: Responsive.scaleFromFigma(context, 21),
                    height: Responsive.scaleFromFigma(context, 26),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Responsive.scaleFromFigma(context, 32),
        ),
        Text(
          textAlign: TextAlign.center,
          'امیرعلی طاهرخانی',
          style: TextStyle(
            fontFamily: 'SB',
            fontSize: Responsive.scaleFromFigma(context, 16),
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: Responsive.scaleFromFigma(context, 6),
        ),
        Text(
          textAlign: TextAlign.center,
          '09942024303',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: Responsive.scaleFromFigma(context, 10),
            color: MyColors.myGrey,
          ),
        ),
        SizedBox(
          height: Responsive.scaleFromFigma(context, 20),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.scaleFromFigma(context, 44)),
          child: Wrap(
            spacing: Responsive.scaleFromFigma(context, 38),
            runSpacing: Responsive.scaleFromFigma(context, 20),
            textDirection: TextDirection.rtl,
            children: const [
              SizedBox(
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.scaleFromFigma(context, 80)),
          child: ElevatedButton(
            onPressed: () {
              AuthManager.logOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => BlocProvider<AuthBloc>(
                  create: (context) => locator.get()
                    ..stream.forEach(
                      (state) {
                        if (state is AuthResponse) {
                          state.response.fold(
                            (l) {},
                            (r) {
                              globalNavigatorKey.currentState?.pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const MainWrapper(),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  child: LoginScreen(),
                ),
              ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              fixedSize: Size.fromHeight(
                Responsive.scaleFromFigma(context, 50),
              ),
            ),
            child: Text(
              'خروج',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: Responsive.scaleFromFigma(context, 16),
                color: MyColors.myWhite,
              ),
            ),
          ),
        ),
        SizedBox(
          height: Responsive.scaleFromFigma(context, 16),
        ),
        Text(
          textAlign: TextAlign.center,
          'اپل شاپ',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: Responsive.scaleFromFigma(context, 10),
            color: MyColors.myGrey,
          ),
        ),
        SizedBox(
          height: Responsive.scaleFromFigma(context, 5),
        ),
        Text(
          textAlign: TextAlign.center,
          'V-1.0.00',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: Responsive.scaleFromFigma(context, 10),
            color: MyColors.myGrey,
          ),
        ),
        SizedBox(
          height: Responsive.scaleFromFigma(context, 5),
        ),
        Text(
          textAlign: TextAlign.center,
          'Instagram.com/Mojavad-dev',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: Responsive.scaleFromFigma(context, 10),
            color: MyColors.myGrey,
          ),
        ),
        SizedBox(
          height: Responsive.scaleFromFigma(context, 107),
        ),
      ],
    );
  }
}
