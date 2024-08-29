import 'package:apple_shop/bloc/home/bloc/home_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/cubit/scroll/cubit/scroll_cubit.dart';
import 'package:apple_shop/models/banner.dart';
import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/models/product.dart';
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
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              _getAppBar(),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 32,
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
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 32,
                  ),
                ),
                _getCategoryListTitle(),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
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
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 32,
                  ),
                ),
                _getBestSellTitle(),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
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
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 32,
                  ),
                ),
                _getMostPopularTitle(),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
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
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 100),
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
        height: 217,
        child: ListView.builder(
          clipBehavior: Clip.none,
          reverse: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 20.0, right: index == 0 ? 44 : 0),
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
    return const SliverToBoxAdapter(
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
    );
  }

  SliverToBoxAdapter _getBestSellList(List<Product> productBestSellerList) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 217,
        child: ListView.builder(
          clipBehavior: Clip.none,
          reverse: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 20.0, right: index == 0 ? 44 : 0),
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
    return const SliverToBoxAdapter(
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
    );
  }

  SliverToBoxAdapter _getCategoryList(List<Category> categoryList) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 83,
        child: ListView.builder(
          clipBehavior: Clip.none,
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 20.0, right: index == 0 ? 44 : 0),
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
    return const SliverToBoxAdapter(
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
      expandedHeight: 46.0,
      floating: true,
      pinned: false,
      flexibleSpace: Padding(
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
    );
  }
}
