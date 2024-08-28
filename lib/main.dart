import 'dart:ui';

import 'package:apple_shop/bloc/authentication/bloc/auth_bloc.dart';
import 'package:apple_shop/bloc/category/bloc/category_bloc.dart';
import 'package:apple_shop/bloc/home/bloc/home_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/cubit/scroll/cubit/scroll_cubit.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/screens/card_screen.dart';
import 'package:apple_shop/screens/category_screen.dart';
import 'package:apple_shop/screens/home_screen.dart';
import 'package:apple_shop/screens/profile_screen.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ScrollCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedBottomNavigationIndex = 3;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.myWhite,
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colors.transparent,
          selectionColor: MyColors.myBlue,
          cursorColor: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: MyColors.myWhite,
          scrolledUnderElevation: 0,
        ),
        extendBody: true,
        bottomNavigationBar: BlocBuilder<ScrollCubit, bool>(
          builder: (context, state) {
            return AnimatedCrossFade(
              crossFadeState:
                  state ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 400),
              secondChild: SizedBox(
                height: 0,
                width: MediaQuery.of(context).size.width,
              ),
              firstChild: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 13,
                    sigmaY: 13,
                  ),
                  child: SizedBox(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: BottomNavigationBar(
                      onTap: (int index) {
                        setState(
                          () {
                            selectedBottomNavigationIndex = index;
                          },
                        );
                      },
                      currentIndex: selectedBottomNavigationIndex,
                      selectedItemColor: MyColors.myBlue,
                      unselectedItemColor: Colors.black,
                      selectedFontSize: 20,
                      unselectedFontSize: 10,
                      showSelectedLabels: true,
                      unselectedLabelStyle: const TextStyle(
                        fontFamily: 'SB',
                        fontSize: 10,
                      ),
                      selectedLabelStyle: const TextStyle(
                        fontFamily: 'SB',
                        fontSize: 10,
                      ),
                      unselectedIconTheme: const IconThemeData(
                        color: Colors.black,
                      ),
                      showUnselectedLabels: true,
                      selectedIconTheme: const IconThemeData(
                        color: MyColors.myBlue,
                      ),
                      iconSize: 30,
                      elevation: 0,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.white.withOpacity(0.7),
                      items: const [
                        BottomNavigationBarItem(
                          activeIcon: Icon(IconsaxBold.profile_circle),
                          backgroundColor: Colors.transparent,
                          label: 'حساب کاربری',
                          icon: Icon(IconsaxOutline.profile_circle),
                        ),
                        BottomNavigationBarItem(
                          activeIcon: Icon(IconsaxBold.bag_2),
                          backgroundColor: Colors.transparent,
                          icon: Icon(IconsaxOutline.bag_2),
                          label: 'سبد خرید',
                        ),
                        BottomNavigationBarItem(
                          activeIcon: Icon(IconsaxBold.category_2),
                          backgroundColor: Colors.transparent,
                          icon: Icon(IconsaxOutline.category_2),
                          label: 'دسته بندی',
                        ),
                        BottomNavigationBarItem(
                          activeIcon: Icon(IconsaxBold.home),
                          backgroundColor: Colors.transparent,
                          icon: Icon(IconsaxOutline.home),
                          label: 'خانه',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        body: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: selectedBottomNavigationIndex,
            children: getScreens(),
          ),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      const ProfileScreen(),
      const CardScreen(),
      const CategoryScreen(),
      const HomeScreen(),
    ];
  }
}
