import 'dart:ui';

import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/screens/category_screen.dart';
import 'package:apple_shop/screens/home_screen.dart';
import 'package:apple_shop/screens/product_list_screen.dart';
import 'package:ficonsax/ficonsax.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        extendBody: true,
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              height: 75,
              decoration: const BoxDecoration(
                backgroundBlendMode: BlendMode.overlay,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0.4),
                    Color.fromRGBO(255, 255, 255, 0.1),
                  ],
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: 3,
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
                backgroundColor: Colors.transparent,
                items: const [
                  BottomNavigationBarItem(
                    label: 'حساب کاربری',
                    icon: Icon(IconsaxOutline.profile_circle),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconsaxOutline.bag_2),
                    label: 'سبد خرید',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconsaxOutline.category_2),
                    label: 'دسته بندی',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconsaxBold.home),
                    label: 'خانه',
                  )
                ],
              ),
            ),
          ),
        ),
        body: const HomeScreen(),
      ),
    );
  }
}
