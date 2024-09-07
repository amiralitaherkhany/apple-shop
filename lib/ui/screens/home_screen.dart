import 'package:apple_shop/bloc/home/bloc/home_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/cubit/scroll/cubit/scroll_cubit.dart';
import 'package:apple_shop/models/banner.dart';
import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/ui/widgets/banner_slider.dart';
import 'package:apple_shop/ui/widgets/category_item_chip.dart';
import 'package:apple_shop/ui/widgets/product_item.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        if (state is HomeResponseSuccess) {
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
                    height: 10.h,
                  ),
                ),
                _getAppBar(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 22.h,
                  ),
                ),
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
                    height: 32.h,
                  ),
                ),
                _getCategoryListTitle(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20.h,
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
                    height: 32.h,
                  ),
                ),
                _getBestSellTitle(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20.h,
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
                    height: 32.h,
                  ),
                ),
                _getMostPopularTitle(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20.h,
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
                  padding: EdgeInsets.only(bottom: 100.h),
                ),
              ],
            ),
          );
        } else if (state is HomeInitial || state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.myBlue,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  SliverToBoxAdapter _getMostPopularList(List<Product> productHottestList) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 217.h,
        child: ListView.builder(
          clipBehavior: Clip.none,
          reverse: true,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  EdgeInsets.only(left: 20.w, right: index == 0 ? 44.w : 0),
              child: ProductItem(
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
        padding: EdgeInsets.symmetric(horizontal: 44.w),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              IconsaxOutline.arrow_circle_left,
              color: MyColors.myBlue,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'مشاهده همه',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12.sp,
                color: MyColors.myBlue,
              ),
            ),
            const Spacer(),
            Text(
              'پر بازدید ترین ها',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12.sp,
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
        height: 217.h,
        child: ListView.builder(
          clipBehavior: Clip.none,
          reverse: true,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  EdgeInsets.only(left: 20.w, right: index == 0 ? 44.w : 0),
              child: ProductItem(
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
        padding: EdgeInsets.symmetric(horizontal: 44.w),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              IconsaxOutline.arrow_circle_left,
              color: MyColors.myBlue,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'مشاهده همه',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12.sp,
                color: MyColors.myBlue,
              ),
            ),
            const Spacer(),
            Text(
              'پر فروش ترین ها',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12.sp,
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
        height: 90.h,
        child: ListView.builder(
          clipBehavior: Clip.none,
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  EdgeInsets.only(left: 20.w, right: index == 0 ? 44.w : 0),
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
              fontSize: 12.sp,
              color: MyColors.myGrey,
            ),
          ),
          SizedBox(
            width: 44.w,
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
      expandedHeight: 46.h,
      floating: true,
      pinned: false,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(horizontal: 44.w),
        child: Container(
          width: 340.w,
          height: 46.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 15.w,
              ),
              Image.asset(
                'assets/images/icon_apple_blue.png',
                width: 21.w,
                height: 26.h,
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 16.sp,
                          color: MyColors.myGrey,
                        ),
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(8.r),
                          hintText: 'جستجوی محصولات',
                          hintStyle: TextStyle(
                            fontFamily: 'SB',
                            fontSize: 16.sp,
                            color: MyColors.myGrey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                IconsaxOutline.search_normal_1,
                size: 30.w,
                color: Colors.black,
              ),
              SizedBox(
                width: 15.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
