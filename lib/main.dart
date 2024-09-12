import 'dart:ui';

import 'package:apple_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/cubit/basket/cubit/basket_cubit.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/card_item.dart';
import 'package:apple_shop/ui/screens/basket_screen.dart';
import 'package:apple_shop/ui/screens/category_screen.dart';
import 'package:apple_shop/ui/screens/home_screen.dart';
import 'package:apple_shop/ui/screens/profile_screen.dart';
import 'package:apple_shop/util/responsive.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('BasketBox');
  await getItInit();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<BasketCubit>(
          create: (context) => locator.get()..updateBasketItems(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => locator.get(),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => locator.get()..add(CategoryRequestList()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => locator.get()..add(HomeRequestData()),
        ),
        BlocProvider<BasketBloc>(
          create: (context) => locator.get()..add(BasketFetchFromHive()),
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
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          backgroundColor: MyColors.myWhite,
          scrolledUnderElevation: 0,
        ),
        extendBody: true,
        bottomNavigationBar: BlocBuilder<BasketCubit, int>(
          builder: (context, state) {
            return ClipRRect(
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
                        icon: Badge.count(
                          isLabelVisible: state == 0 ? false : true,
                          count: state,
                          child: const Icon(IconsaxOutline.bag_2),
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
      const BasketScreen(),
      const CategoryScreen(),
      const HomeScreen(),
    ];
  }
}
