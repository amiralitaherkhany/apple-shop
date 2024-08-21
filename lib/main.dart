import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/widgets/card_item.dart';
import 'package:apple_shop/widgets/category_horizontal_item_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: MyColors.myWhite,
        body: SafeArea(
          child: Center(
            child: CardItem(),
          ),
        ),
      ),
    );
  }

  ListView getCategoryList() {
    return ListView.builder(
      reverse: true,
      scrollDirection: Axis.horizontal,
      itemCount: 20,
      itemBuilder: (context, index) {
        return CategoryHorizontalItemList(
          index: index,
        );
      },
    );
  }
}
