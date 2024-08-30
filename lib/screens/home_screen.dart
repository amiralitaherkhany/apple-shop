import 'package:apple_shop/bloc/home/bloc/home_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/cubit/scroll/cubit/scroll_cubit.dart';
import 'package:apple_shop/models/banner.dart';
import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/util/responsive.dart';
import 'package:apple_shop/widgets/banner_slider.dart';
import 'package:apple_shop/widgets/card_item.dart';
import 'package:apple_shop/widgets/category_item_chip.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(
      _scrollListener,
    );
    context.read<HomeBloc>().add(HomeRequestData());
    super.initState();
  }

  void _scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      context.read<ScrollCubit>().hide();
    } else {
      context.read<ScrollCubit>().show();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return RefreshIndicator(
          color: MyColors.myBlue,
          backgroundColor: MyColors.myWhite,
          onRefresh: () async {
            context.read<HomeBloc>().add(HomeRequestData());
            await Future.delayed(Durations.short1);
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Responsive.scaleFromFigma(context, 10),
                ),
              ),
              _getAppBar(),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Responsive.scaleFromFigma(context, 32),
                ),
              ),
              if (state is HomeInitial || state is HomeLoading) ...[
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 250,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: MyColors.myBlue,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (state is HomeResponseSuccess) ...[
                state.bannerList.fold(
                  (exception) {
                    return SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(exception),
                        ],
                      ),
                    );
                  },
                  (bannerList) {
                    return _getBanners(bannerList);
                  },
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Responsive.scaleFromFigma(context, 32),
                  ),
                ),
                _getCategoryListTitle(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Responsive.scaleFromFigma(context, 20),
                  ),
                ),
                state.categoryList.fold(
                  (exception) {
                    return SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(exception),
                        ],
                      ),
                    );
                  },
                  (categoryList) {
                    return _getCategoryList(categoryList);
                  },
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Responsive.scaleFromFigma(context, 32),
                  ),
                ),
                _getBestSellTitle(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Responsive.scaleFromFigma(context, 20),
                  ),
                ),
                state.productBestSellerList.fold(
                  (exception) {
                    return SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(exception),
                        ],
                      ),
                    );
                  },
                  (productBestSellerList) {
                    return _getBestSellList(productBestSellerList);
                  },
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Responsive.scaleFromFigma(context, 32),
                  ),
                ),
                _getMostPopularTitle(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Responsive.scaleFromFigma(context, 20),
                  ),
                ),
                state.productHottestList.fold(
                  (exception) {
                    return SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(exception),
                        ],
                      ),
                    );
                  },
                  (productHottestList) {
                    return _getMostPopularList(productHottestList);
                  },
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                      bottom: Responsive.scaleFromFigma(context, 100)),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  SliverToBoxAdapter _getMostPopularList(List<Product> productHottestList) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: Responsive.scaleFromFigma(context, 217),
        child: ListView.builder(
          clipBehavior: Clip.none,
          reverse: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: Responsive.scaleFromFigma(context, 20),
                  right:
                      index == 0 ? Responsive.scaleFromFigma(context, 44) : 0),
              child: CardItem(
                product: productHottestList[index],
              ),
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: productHottestList.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter _getMostPopularTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.scaleFromFigma(context, 44)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              IconsaxOutline.arrow_circle_left,
              color: MyColors.myBlue,
            ),
            SizedBox(
              width: Responsive.scaleFromFigma(context, 10),
            ),
            Text(
              'مشاهده همه',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: Responsive.scaleFromFigma(context, 12),
                color: MyColors.myBlue,
              ),
            ),
            const Spacer(),
            Text(
              'پر بازدید ترین ها',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: Responsive.scaleFromFigma(context, 12),
                color: MyColors.myGrey,
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _getBestSellList(List<Product> productBestSellerList) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: Responsive.scaleFromFigma(context, 217),
        child: ListView.builder(
          clipBehavior: Clip.none,
          reverse: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: Responsive.scaleFromFigma(context, 20),
                  right:
                      index == 0 ? Responsive.scaleFromFigma(context, 44) : 0),
              child: CardItem(
                product: productBestSellerList[index],
              ),
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: productBestSellerList.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter _getBestSellTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.scaleFromFigma(context, 44)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              IconsaxOutline.arrow_circle_left,
              color: MyColors.myBlue,
            ),
            SizedBox(
              width: Responsive.scaleFromFigma(context, 10),
            ),
            Text(
              'مشاهده همه',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: Responsive.scaleFromFigma(context, 12),
                color: MyColors.myBlue,
              ),
            ),
            const Spacer(),
            Text(
              'پر فروش ترین ها',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: Responsive.scaleFromFigma(context, 12),
                color: MyColors.myGrey,
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _getCategoryList(List<Category> categoryList) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: Responsive.scaleFromFigma(context, 90),
        child: ListView.builder(
          clipBehavior: Clip.none,
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: Responsive.scaleFromFigma(context, 20),
                  right:
                      index == 0 ? Responsive.scaleFromFigma(context, 44) : 0),
              child: CategoryItemChip(
                category: categoryList[index],
              ),
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _getCategoryListTitle() {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'دسته بندی',
            style: TextStyle(
              fontFamily: 'SB',
              fontSize: Responsive.scaleFromFigma(context, 12),
              color: MyColors.myGrey,
            ),
          ),
          SizedBox(
            width: Responsive.scaleFromFigma(context, 44),
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter _getBanners(List<BannerModel> bannerList) {
    return SliverToBoxAdapter(
      child: BannerSlider(
        bannerList: bannerList,
      ),
    );
  }

  SliverAppBar _getAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      expandedHeight: Responsive.scaleFromFigma(context, 46),
      floating: true,
      pinned: false,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.scaleFromFigma(context, 44)),
        child: Container(
          width: Responsive.scaleFromFigma(context, 340),
          height: Responsive.scaleFromFigma(context, 46),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Responsive.scaleFromFigma(context, 15),
              ),
              Image.asset(
                'assets/images/icon_apple_blue.png',
                width: Responsive.scaleFromFigma(context, 21),
                height: Responsive.scaleFromFigma(context, 26),
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: Responsive.scaleFromFigma(context, 16),
                      color: MyColors.myGrey,
                    ),
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: 'جستجوی محصولات',
                      hintStyle: TextStyle(
                        fontFamily: 'SB',
                        fontSize: Responsive.scaleFromFigma(context, 16),
                        color: MyColors.myGrey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Responsive.scaleFromFigma(context, 10),
              ),
              Icon(
                IconsaxOutline.search_normal_1,
                size: Responsive.scaleFromFigma(context, 30),
                color: Colors.black,
              ),
              SizedBox(
                width: Responsive.scaleFromFigma(context, 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
