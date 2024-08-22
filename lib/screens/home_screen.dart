import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/widgets/banner_slider.dart';
import 'package:apple_shop/widgets/card_item.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Image.asset('assets/images/icon_apple_blue.png'),
                      const Expanded(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16,
                              color: MyColors.myGrey,
                            ),
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              hintText: 'جستجوی محصولات',
                              hintStyle: TextStyle(
                                fontFamily: 'SB',
                                fontSize: 16,
                                color: MyColors.myGrey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        IconsaxOutline.search_normal_1,
                        size: 30,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 15,
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
            const SliverToBoxAdapter(
              child: BannerSlider(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 32,
              ),
            ),
            const SliverToBoxAdapter(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'دسته بندی',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 12,
                      color: MyColors.myGrey,
                    ),
                  ),
                  SizedBox(
                    width: 44,
                  )
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 83,
                child: getCategoryList(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 32,
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 44.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      IconsaxOutline.arrow_circle_left,
                      color: MyColors.myBlue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'مشاهده همه',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                        color: MyColors.myBlue,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'پر فروش ترین ها',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                        color: MyColors.myGrey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 217,
                child: ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) => CardItem(
                    index: index,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 32,
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 44.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      IconsaxOutline.arrow_circle_left,
                      color: MyColors.myBlue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'مشاهده همه',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                        color: MyColors.myBlue,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'پر بازدید ترین ها',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                        color: MyColors.myGrey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 217,
                child: ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) => CardItem(
                    index: index,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                ),
              ),
            )
          ],
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

class CategoryHorizontalItemList extends StatelessWidget {
  const CategoryHorizontalItemList({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: index == 0 ? 44 : 0),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: ShapeDecoration(
              shadows: const [
                BoxShadow(
                  offset: Offset(0, 2.77),
                  blurRadius: 2.21,
                  spreadRadius: 0,
                  color: Color.fromRGBO(251, 173, 64, 0.04),
                ),
                BoxShadow(
                  offset: Offset(0, 6.65),
                  blurRadius: 5.32,
                  spreadRadius: 0,
                  color: Color.fromRGBO(251, 173, 64, 0.04),
                ),
                BoxShadow(
                  offset: Offset(0, 12.52),
                  blurRadius: 10.02,
                  spreadRadius: 0,
                  color: Color.fromRGBO(251, 173, 64, 0.05),
                ),
                BoxShadow(
                  offset: Offset(0, 22.34),
                  blurRadius: 17.87,
                  spreadRadius: 0,
                  color: Color.fromRGBO(251, 173, 64, 0.05),
                ),
                BoxShadow(
                  offset: Offset(0, 41.78),
                  blurRadius: 33.42,
                  spreadRadius: 0,
                  color: Color.fromRGBO(251, 173, 64, 0.05),
                ),
                BoxShadow(
                  offset: Offset(0, 100),
                  blurRadius: 80,
                  spreadRadius: 0,
                  color: Color.fromRGBO(251, 173, 64, 0.07),
                ),
              ],
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
              color: const Color.fromRGBO(251, 173, 64, 1),
            ),
            child: const Icon(
              Icons.ads_click,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'همه',
            style: TextStyle(
              fontFamily: 'SB',
              color: Colors.black,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
