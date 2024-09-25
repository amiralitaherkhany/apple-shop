import 'dart:ui';

import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/ui/screens/basket_screen.dart';
import 'package:apple_shop/ui/screens/category_screen.dart';
import 'package:apple_shop/ui/screens/home_screen.dart';
import 'package:apple_shop/ui/screens/profile_screen.dart';
import 'package:apple_shop/util/responsive.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedBottomNavigationIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor: MyColors.myWhite,
        scrolledUnderElevation: 0,
      ),
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 13,
            sigmaY: 13,
          ),
          child: SizedBox(
            height: Responsive.scaleFromFigma(context, 75),
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
              selectedFontSize: Responsive.scaleFromFigma(context, 20),
              unselectedFontSize: Responsive.scaleFromFigma(context, 10),
              showSelectedLabels: true,
              unselectedLabelStyle: TextStyle(
                fontFamily: 'SB',
                fontSize: Responsive.scaleFromFigma(context, 10),
              ),
              selectedLabelStyle: TextStyle(
                fontFamily: 'SB',
                fontSize: Responsive.scaleFromFigma(context, 10),
              ),
              unselectedIconTheme: const IconThemeData(
                color: Colors.black,
              ),
              showUnselectedLabels: true,
              selectedIconTheme: const IconThemeData(
                color: MyColors.myBlue,
              ),
              iconSize: Responsive.scaleFromFigma(context, 30),
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white.withOpacity(0.7),
              items: [
                const BottomNavigationBarItem(
                  activeIcon: Icon(IconsaxBold.profile_circle),
                  backgroundColor: Colors.transparent,
                  label: 'حساب کاربری',
                  icon: Icon(IconsaxOutline.profile_circle),
                ),
                BottomNavigationBarItem(
                  activeIcon: const Icon(IconsaxBold.bag_2),
                  backgroundColor: Colors.transparent,
                  icon: BlocBuilder<BasketBloc, BasketState>(
                    builder: (context, state) {
                      if (state is BasketInitial) {
                        return Badge.count(
                          isLabelVisible: false,
                          count: 0,
                          child: const Icon(IconsaxOutline.bag_2),
                        );
                      } else if (state is BasketDataFetched) {
                        return state.basketItems.fold(
                          (error) {
                            return Badge.count(
                              isLabelVisible: false,
                              count: 0,
                              child: const Icon(IconsaxOutline.bag_2),
                            );
                          },
                          (basketItems) {
                            return Badge.count(
                              isLabelVisible:
                                  basketItems.isEmpty ? false : true,
                              count: basketItems.length,
                              child: const Icon(IconsaxOutline.bag_2),
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  label: 'سبد خرید',
                ),
                const BottomNavigationBarItem(
                  activeIcon: Icon(IconsaxBold.category_2),
                  backgroundColor: Colors.transparent,
                  icon: Icon(IconsaxOutline.category_2),
                  label: 'دسته بندی',
                ),
                const BottomNavigationBarItem(
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
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: selectedBottomNavigationIndex,
          children: getScreens(),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      const ProfileScreen(),
      const BasketScreen(),
      const CategoryScreen(),
      const HomeScreen(),
    ];
  }
}
