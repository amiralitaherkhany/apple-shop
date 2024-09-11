import 'package:apple_shop/bloc/categoryProduct/bloc/category_product_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/ui/widgets/custom_loading_widget.dart';
import 'package:apple_shop/ui/widgets/product_item.dart';
import 'package:apple_shop/util/responsive.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({
    super.key,
    required this.category,
  });
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CategoryProductBloc, CategoryProductState>(
          builder: (context, state) {
            if (state is CategoryProductInitial ||
                state is CategoryProductLoading) {
              return const CustomLoadingWidget();
            } else if (state is CategoryProductResponse) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.scaleFromFigma(context, 10),
                    ),
                  ),
                  SliverAppBar(
                    automaticallyImplyLeading: false,
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
                              category.title!,
                              style: TextStyle(
                                fontFamily: 'SB',
                                fontSize:
                                    Responsive.scaleFromFigma(context, 16),
                                color: MyColors.myBlue,
                              ),
                            ),
                            Positioned(
                              left: Responsive.scaleFromFigma(context, 15),
                              child: Icon(
                                IconsaxOutline.filter,
                                size: Responsive.scaleFromFigma(context, 30),
                              ),
                            ),
                            Positioned(
                              right: Responsive.scaleFromFigma(context, 5),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                    IconsaxOutline.arrow_circle_right),
                                iconSize:
                                    Responsive.scaleFromFigma(context, 30),
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
                  state.productList.fold(
                    (exception) {
                      return SliverToBoxAdapter(
                        child: Text(
                          textAlign: TextAlign.center,
                          exception,
                          style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: Responsive.scaleFromFigma(context, 16),
                            color: MyColors.myBlue,
                          ),
                        ),
                      );
                    },
                    (productList) {
                      if (productList.isNotEmpty) {
                        return ProductGrid(productlist: productList);
                      } else {
                        return SliverToBoxAdapter(
                          child: Text(
                            textAlign: TextAlign.center,
                            'محصولی دراین دسته بندی وجود ندارد',
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: Responsive.scaleFromFigma(context, 16),
                              color: MyColors.myBlue,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('error'));
            }
          },
        ),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.productlist,
  });
  final List<Product> productlist;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.scaleFromFigma(context, 38)),
      sliver: SliverGrid.builder(
        itemCount: productlist.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: Responsive.scaleFromFigma(context, 20),
          mainAxisSpacing: Responsive.scaleFromFigma(context, 20),
          mainAxisExtent: Responsive.scaleFromFigma(context, 216),
        ),
        itemBuilder: (context, index) {
          return ProductItem(product: productlist[index]);
        },
      ),
    );
  }
}
