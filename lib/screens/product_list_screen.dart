import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/widgets/card_item.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44),
                child: Container(
                  width: 340,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: const Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Text(
                        'پرفروش ترین ها',
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 16,
                          color: MyColors.myBlue,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        child: Icon(
                          IconsaxOutline.filter,
                          size: 30,
                        ),
                      ),
                      Positioned(
                        right: 15,
                        child: Icon(
                          IconsaxOutline.arrow_circle_right,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 32,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              sliver: SliverGrid.builder(
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 216,
                ),
                itemBuilder: (context, index) {
                  return CardItem(
                    index: index,
                    isGrid: true,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
