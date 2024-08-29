import 'package:apple_shop/constants/colors.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/scroll/cubit/scroll_cubit.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late final ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(
      _scrollListener,
    );
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
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
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
                  // return const CardItem();
                  return const Text('data');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
