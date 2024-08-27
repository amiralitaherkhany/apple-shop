import 'package:apple_shop/bloc/category/bloc/category_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/cubit/scroll/cubit/scroll_cubit.dart';
import 'package:apple_shop/model/category.dart';
import 'package:apple_shop/widgets/cached_image.dart';
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
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverAppBar(
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
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const Text(
                    'دسته بندی',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 16,
                      color: MyColors.myBlue,
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 10,
                    child: Image.asset('assets/images/icon_apple_blue.png'),
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
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryInitial || state is CategoryLoading) {
              return const SliverToBoxAdapter(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryResponse) {
              return state.response.fold(
                (l) {
                  return SliverToBoxAdapter(
                    child: Text(l),
                  );
                },
                (r) {
                  return CategoryList(categoryList: r);
                },
              );
            } else {
              return const SliverToBoxAdapter(
                child: Text('error'),
              );
            }
          },
        ),
        const SliverPadding(
          padding: EdgeInsets.only(bottom: 80),
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
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid.builder(
        itemCount: categoryList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          return CachedImage(imageUrl: categoryList[index].thumbnail!);
        },
      ),
    );
  }
}
