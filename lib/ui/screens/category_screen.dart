import 'package:apple_shop/bloc/category/bloc/category_bloc.dart';
import 'package:apple_shop/bloc/categoryProduct/bloc/category_product_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/cubit/scroll/cubit/scroll_cubit.dart';
import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/ui/screens/product_list_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(
      _scrollListener,
    );

    context.read<CategoryBloc>().add(CategoryRequestList());
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
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10.h,
          ),
        ),
        SliverAppBar(
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
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.white,
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    'دسته بندی',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 16.sp,
                      color: MyColors.myBlue,
                    ),
                  ),
                  Positioned(
                    left: 15.w,
                    top: 10.h,
                    child: Image.asset(
                      'assets/images/icon_apple_blue.png',
                      width: 21.w,
                      height: 26.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 32.h,
          ),
        ),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryInitial || state is CategoryLoading) {
              return const SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: MyColors.myBlue,
                    ),
                  ],
                ),
              );
            } else if (state is CategoryResponse) {
              return state.response.fold(
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
                  return CategoryList(categoryList: categoryList);
                },
              );
            } else {
              return const SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('error'),
                  ],
                ),
              );
            }
          },
        ),
        SliverPadding(
          padding: EdgeInsets.only(bottom: 80.h),
        ),
      ],
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.categoryList});

  final List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 44.w),
      sliver: SliverGrid.builder(
        itemCount: categoryList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 20.h,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => CategoryProductBloc()
                    ..add(CategoryProductRequestData(
                        categoryId: categoryList[index].id!)),
                  child: ProductListScreen(category: categoryList[index]),
                ),
              ));
            },
            child: CachedNetworkImage(
              placeholder: (context, url) => Container(
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.red[500],
              ),
              imageUrl: categoryList[index].thumbnail!,
              width: 160.w,
              height: 160.h,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
