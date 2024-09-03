import 'package:apple_shop/bloc/category/bloc/category_bloc.dart';
import 'package:apple_shop/bloc/categoryProduct/bloc/category_product_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/cubit/scroll/cubit/scroll_cubit.dart';
import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/ui/screens/product_list_screen.dart';
import 'package:apple_shop/util/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            height: Responsive.scaleFromFigma(context, 10),
          ),
        ),
        SliverAppBar(
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
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    'دسته بندی',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: Responsive.scaleFromFigma(context, 16),
                      color: MyColors.myBlue,
                    ),
                  ),
                  Positioned(
                    left: Responsive.scaleFromFigma(context, 15),
                    top: Responsive.scaleFromFigma(context, 10),
                    child: Image.asset(
                      'assets/images/icon_apple_blue.png',
                      width: Responsive.scaleFromFigma(context, 21),
                      height: Responsive.scaleFromFigma(context, 26),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Responsive.scaleFromFigma(context, 32),
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
          padding:
              EdgeInsets.only(bottom: Responsive.scaleFromFigma(context, 80)),
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
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.scaleFromFigma(context, 44)),
      sliver: SliverGrid.builder(
        itemCount: categoryList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: Responsive.scaleFromFigma(context, 20),
          mainAxisSpacing: Responsive.scaleFromFigma(context, 20),
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
              width: Responsive.scaleFromFigma(context, 160),
              height: Responsive.scaleFromFigma(context, 160),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
