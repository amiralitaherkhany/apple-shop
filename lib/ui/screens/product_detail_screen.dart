import 'dart:ui';

import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/comment/comment_bloc.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/cubit/basket/cubit/basket_cubit.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/models/product_image.dart';
import 'package:apple_shop/models/product_property.dart';
import 'package:apple_shop/models/product_variant.dart';
import 'package:apple_shop/models/variant.dart';
import 'package:apple_shop/models/variant_type.dart';
import 'package:apple_shop/ui/widgets/custom_loading_widget.dart';
import 'package:apple_shop/util/extensions/int_extensions.dart';
import 'package:apple_shop/util/extensions/string_extensions.dart';
import 'package:apple_shop/util/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductInitial || state is ProductLoading) {
              return const CustomLoadingWidget();
            } else if (state is ProductResponse) {
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
                              state.productCategory.fold(
                                (exception) {
                                  return 'دسته بندی';
                                },
                                (category) {
                                  return category.title!;
                                },
                              ),
                              style: TextStyle(
                                fontFamily: 'SB',
                                fontSize:
                                    Responsive.scaleFromFigma(context, 16),
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
                            Positioned(
                              right: Responsive.scaleFromFigma(context, 5),
                              child: IconButton(
                                iconSize:
                                    Responsive.scaleFromFigma(context, 30),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  IconsaxOutline.arrow_circle_right,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.scaleFromFigma(context, 22),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      textAlign: TextAlign.center,
                      product.name,
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: Responsive.scaleFromFigma(context, 16),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.scaleFromFigma(context, 20),
                    ),
                  ),
                  state.productImageList.fold(
                    (exception) {
                      return SliverToBoxAdapter(child: Text(exception));
                    },
                    (productImageList) {
                      return GalleryWidget(
                        productImageList: productImageList,
                        defaultProductThumbnail: product.thumbnail,
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.scaleFromFigma(context, 20),
                    ),
                  ),
                  state.productVariantList.fold(
                    (exception) {
                      return SliverToBoxAdapter(child: Text(exception));
                    },
                    (productVariantList) {
                      return SliverToBoxAdapter(
                        child: VariantContainerGenerator(
                            productVariantList: productVariantList),
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.scaleFromFigma(context, 10),
                    ),
                  ),
                  state.productProperties.fold(
                    (exception) {
                      return SliverToBoxAdapter(
                        child: Text(exception),
                      );
                    },
                    (productProperties) {
                      if (productProperties.isNotEmpty) {
                        return ProductProperties(
                            productProperties: productProperties);
                      } else {
                        return const SliverToBoxAdapter(
                          child: SizedBox(
                            width: 0,
                            height: 0,
                          ),
                        );
                      }
                    },
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.scaleFromFigma(context, 20),
                    ),
                  ),
                  ProductDescription(
                    productDescription: product.description,
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.scaleFromFigma(context, 20),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.scaleFromFigma(context, 44)),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: MyColors.myWhite,
                            isDismissible: true,
                            useSafeArea: true,
                            isScrollControlled: true,
                            enableDrag: true,
                            context: context,
                            builder: (context) {
                              return BlocProvider<CommentBloc>(
                                create: (context) => locator.get()
                                  ..add(CommentRequestData(
                                      productId: product.id)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: DraggableScrollableSheet(
                                    initialChildSize: 0.55,
                                    maxChildSize: 1,
                                    minChildSize: 0.3,
                                    snapAnimationDuration: Durations.medium1,
                                    snapSizes: const [0.3, 0.55, 1],
                                    expand: false,
                                    snap: true,
                                    builder: (context, scrollController) =>
                                        Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Positioned(
                                          top: 15,
                                          child: Container(
                                            width: 80,
                                            height: 5,
                                            decoration: BoxDecoration(
                                              color: MyColors.myBlue,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        CommentBottomSheet(
                                          scrollController: scrollController,
                                          productId: product.id,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: Responsive.scaleFromFigma(context, 46),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MyColors.myGrey,
                              width: 1,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    Responsive.scaleFromFigma(context, 10)),
                            child: Row(
                              children: [
                                const Icon(
                                  IconsaxOutline.arrow_circle_left,
                                  color: MyColors.myBlue,
                                ),
                                SizedBox(
                                  width: Responsive.scaleFromFigma(context, 10),
                                ),
                                Text(
                                  'مشاهده',
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize:
                                        Responsive.scaleFromFigma(context, 12),
                                    color: MyColors.myBlue,
                                  ),
                                ),
                                const Spacer(),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: Responsive.scaleFromFigma(
                                          context, 26),
                                      height: Responsive.scaleFromFigma(
                                          context, 26),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Responsive.scaleFromFigma(
                                                context, 8)),
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: Responsive.scaleFromFigma(
                                          context, 18),
                                      child: Container(
                                        width: Responsive.scaleFromFigma(
                                            context, 26),
                                        height: Responsive.scaleFromFigma(
                                            context, 26),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Responsive.scaleFromFigma(
                                                  context, 8)),
                                          color: Colors.green,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: Responsive.scaleFromFigma(
                                          context, 36),
                                      child: Container(
                                        width: Responsive.scaleFromFigma(
                                            context, 26),
                                        height: Responsive.scaleFromFigma(
                                            context, 26),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Responsive.scaleFromFigma(
                                                  context, 8)),
                                          color: Colors.yellow,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: Responsive.scaleFromFigma(
                                          context, 54),
                                      child: Container(
                                        width: Responsive.scaleFromFigma(
                                            context, 26),
                                        height: Responsive.scaleFromFigma(
                                            context, 26),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Responsive.scaleFromFigma(
                                                  context, 8)),
                                          color: Colors.blue,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: Responsive.scaleFromFigma(
                                          context, 72),
                                      child: Container(
                                        width: Responsive.scaleFromFigma(
                                            context, 26),
                                        height: Responsive.scaleFromFigma(
                                            context, 26),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Responsive.scaleFromFigma(
                                                  context, 8)),
                                          color: MyColors.myGrey,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '+10',
                                            style: TextStyle(
                                              fontFamily: 'SB',
                                              fontSize:
                                                  Responsive.scaleFromFigma(
                                                      context, 10),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: Responsive.scaleFromFigma(context, 10),
                                ),
                                Text(
                                  ':نظرات کاربران',
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize:
                                        Responsive.scaleFromFigma(context, 12),
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.scaleFromFigma(context, 38),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.scaleFromFigma(context, 44)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PriceTagButton(
                            product: product,
                          ),
                          SizedBox(
                            width: Responsive.scaleFromFigma(context, 44),
                          ),
                          AddToBasketButton(
                            product: product,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.scaleFromFigma(context, 32),
                    ),
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

class CommentBottomSheet extends StatelessWidget {
  CommentBottomSheet({
    super.key,
    required this.scrollController,
    required this.productId,
  });
  final ScrollController scrollController;
  final String productId;
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoading || state is CommentInitial) {
          return const CustomLoadingWidget();
        } else if (state is CommentResponse) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    state.commentList.fold(
                      (exception) {
                        return SliverToBoxAdapter(
                          child: Text(exception),
                        );
                      },
                      (commentList) {
                        if (commentList.isEmpty) {
                          return SliverToBoxAdapter(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'نظری برای این محصول وجود ندارد',
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize:
                                        Responsive.scaleFromFigma(context, 14),
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: commentList.length,
                            (context, index) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: Responsive.scaleFromFigma(
                                          context, 20),
                                      vertical: Responsive.scaleFromFigma(
                                          context, 10)),
                                  padding: EdgeInsets.all(
                                      Responsive.scaleFromFigma(context, 8)),
                                  decoration: BoxDecoration(
                                      color: MyColors.myBlue,
                                      borderRadius: BorderRadius.circular(
                                          Responsive.scaleFromFigma(
                                              context, 15))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            Responsive.scaleFromFigma(
                                                context, 20),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: commentList[index]
                                                .userThumbnailUrl,
                                            width: Responsive.scaleFromFigma(
                                                context, 30),
                                            height: Responsive.scaleFromFigma(
                                                context, 30),
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    'assets/images/avatar.png'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Responsive.scaleFromFigma(
                                            context, 10),
                                      ),
                                      Flexible(
                                        flex: 9,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              commentList[index].userName,
                                              style: TextStyle(
                                                fontFamily: 'SB',
                                                fontSize:
                                                    Responsive.scaleFromFigma(
                                                        context, 14),
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              height: Responsive.scaleFromFigma(
                                                  context, 10),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                commentList[index].text,
                                                style: TextStyle(
                                                  fontFamily: 'SB',
                                                  fontSize:
                                                      Responsive.scaleFromFigma(
                                                          context, 16),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 50),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          hintText: 'افزودن نظر',
                          hintStyle: TextStyle(
                            fontFamily: 'SB',
                            fontSize: Responsive.scaleFromFigma(context, 16),
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            color: MyColors.myBlue,
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              if (textEditingController.text.isEmpty) {
                                return;
                              }
                              context.read<CommentBloc>().add(
                                    CommentPostRequest(
                                        productId: productId,
                                        text: textEditingController.text),
                                  );
                            },
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              strokeAlign: 0,
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              strokeAlign: 0,
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              strokeAlign: 0,
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Text('error');
        }
      },
    );
  }
}

class ProductProperties extends StatefulWidget {
  const ProductProperties({
    super.key,
    required this.productProperties,
  });
  final List<Property> productProperties;
  @override
  State<ProductProperties> createState() => _ProductPropertiesState();
}

class _ProductPropertiesState extends State<ProductProperties> {
  bool _isCollapsed = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.scaleFromFigma(context, 44)),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ExpansionTile(
            onExpansionChanged: (value) {
              setState(() {
                _isCollapsed = !_isCollapsed;
              });
            },
            initiallyExpanded: _isCollapsed,
            expansionAnimationStyle: AnimationStyle(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              reverseCurve: Curves.easeInOut,
            ),
            tilePadding: EdgeInsets.symmetric(
                horizontal: Responsive.scaleFromFigma(context, 10)),
            childrenPadding:
                EdgeInsets.all(Responsive.scaleFromFigma(context, 16)),
            minTileHeight: Responsive.scaleFromFigma(context, 46),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'مشاهده',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: Responsive.scaleFromFigma(context, 12),
                    color: MyColors.myBlue,
                  ),
                ),
                SizedBox(
                  width: Responsive.scaleFromFigma(context, 10),
                ),
                Icon(
                  _isCollapsed
                      ? IconsaxOutline.arrow_circle_down
                      : IconsaxOutline.arrow_circle_left,
                  color: MyColors.myBlue,
                ),
              ],
            ),
            collapsedShape: RoundedRectangleBorder(
              side: const BorderSide(
                color: MyColors.myGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: MyColors.myGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            expandedAlignment: Alignment.centerRight,
            title: Text(
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.end,
              ':مشخصات فنی',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: Responsive.scaleFromFigma(context, 12),
                color: Colors.black,
              ),
            ),
            children: [
              ...List.generate(
                widget.productProperties.length,
                (index) {
                  return Text(
                    '${widget.productProperties[index].title} :  ${widget.productProperties[index].value}',
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: Responsive.scaleFromFigma(context, 14),
                      color: Colors.black,
                      height: 2,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    super.key,
    required this.productDescription,
  });
  final String productDescription;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isCollapsed = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.scaleFromFigma(context, 44)),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ExpansionTile(
            onExpansionChanged: (value) {
              setState(() {
                _isCollapsed = !_isCollapsed;
              });
            },
            initiallyExpanded: _isCollapsed,
            expansionAnimationStyle: AnimationStyle(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              reverseCurve: Curves.easeInOut,
            ),
            tilePadding: EdgeInsets.symmetric(
                horizontal: Responsive.scaleFromFigma(context, 10)),
            childrenPadding:
                EdgeInsets.all(Responsive.scaleFromFigma(context, 16)),
            minTileHeight: Responsive.scaleFromFigma(context, 46),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'مشاهده',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: Responsive.scaleFromFigma(context, 12),
                    color: MyColors.myBlue,
                  ),
                ),
                SizedBox(
                  width: Responsive.scaleFromFigma(context, 10),
                ),
                Icon(
                  _isCollapsed
                      ? IconsaxOutline.arrow_circle_down
                      : IconsaxOutline.arrow_circle_left,
                  color: MyColors.myBlue,
                ),
              ],
            ),
            collapsedShape: RoundedRectangleBorder(
              side: const BorderSide(
                color: MyColors.myGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: MyColors.myGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            title: Text(
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.end,
              ':توضیحات محصول ',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: Responsive.scaleFromFigma(context, 12),
                color: Colors.black,
              ),
            ),
            children: [
              Text(
                widget.productDescription,
                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'SB',
                  fontSize: Responsive.scaleFromFigma(context, 14),
                  color: Colors.black,
                  height: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  const VariantContainerGenerator({
    super.key,
    required this.productVariantList,
  });
  final List<ProductVariant> productVariantList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var productVariant in productVariantList) ...{
          if (productVariant.variantList.isNotEmpty) ...{
            VariantGeneratorChild(productVariant: productVariant)
          },
        }
      ],
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  const VariantGeneratorChild({
    super.key,
    required this.productVariant,
  });
  final ProductVariant productVariant;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.scaleFromFigma(context, 44),
          vertical: Responsive.scaleFromFigma(context, 5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title,
            style: TextStyle(
              fontFamily: 'SB',
              fontSize: Responsive.scaleFromFigma(context, 12),
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: Responsive.scaleFromFigma(context, 10),
          ),
          if (productVariant.variantType.type == VariantTypeEnum.Color) ...[
            ColorVariantList(variantList: productVariant.variantList),
          ],
          if (productVariant.variantType.type == VariantTypeEnum.Storage) ...[
            StorageVariantList(variantList: productVariant.variantList)
          ],
        ],
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({
    super.key,
    required this.productImageList,
    required this.defaultProductThumbnail,
  });
  final List<ProductImage> productImageList;
  final String defaultProductThumbnail;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: Responsive.scaleFromFigma(context, 284),
        margin: EdgeInsets.symmetric(
            horizontal: Responsive.scaleFromFigma(context, 44)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.0335),
              offset: const Offset(0, 2.77),
              blurRadius: 2.21,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.0412),
              offset: const Offset(0, 6.65),
              blurRadius: 5.32,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.0455),
              offset: const Offset(0, 12.52),
              blurRadius: 10.02,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.scaleFromFigma(context, 10)),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Center(
                        key: UniqueKey(),
                        child: CachedNetworkImage(
                          width: Responsive.scaleFromFigma(context, 150),
                          height: Responsive.scaleFromFigma(context, 150),
                          imageUrl: widget.productImageList.isEmpty
                              ? widget.defaultProductThumbnail
                              : widget.productImageList[selectedImage].image,
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/no-image-icon-6.png',
                            width: Responsive.scaleFromFigma(context, 150),
                            height: Responsive.scaleFromFigma(context, 150),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: Responsive.scaleFromFigma(context, 10),
                      left: Responsive.scaleFromFigma(context, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            IconsaxBold.star,
                            color: const Color(0xffFFBF00),
                            size: Responsive.scaleFromFigma(context, 28),
                          ),
                          Text(
                            '4.6',
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: Responsive.scaleFromFigma(context, 12),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: Responsive.scaleFromFigma(context, 10),
                      right: Responsive.scaleFromFigma(context, 5),
                      child: const Icon(
                        IconsaxBold.heart_circle,
                        color: MyColors.myGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Responsive.scaleFromFigma(context, 70),
              child: ListView.builder(
                itemCount: widget.productImageList.isEmpty
                    ? 1
                    : widget.productImageList.length,
                scrollDirection: Axis.horizontal,
                reverse: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedImage = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      margin: EdgeInsets.only(
                        left: Responsive.scaleFromFigma(context, 20),
                        right: index == 0
                            ? Responsive.scaleFromFigma(context, 35)
                            : 0,
                      ),
                      padding: EdgeInsets.all(
                          Responsive.scaleFromFigma(context, 10)),
                      width: Responsive.scaleFromFigma(context, 70),
                      height: Responsive.scaleFromFigma(context, 70),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: index == selectedImage
                              ? MyColors.myBlue
                              : MyColors.myGrey,
                          width: index == selectedImage ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.productImageList.isEmpty
                              ? widget.defaultProductThumbnail
                              : widget.productImageList[index].image,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: Responsive.scaleFromFigma(context, 30),
            ),
          ],
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  const AddToBasketButton({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          width: Responsive.scaleFromFigma(context, 140),
          height: Responsive.scaleFromFigma(context, 47),
          decoration: BoxDecoration(
            color: MyColors.myBlue,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          top: Responsive.scaleFromFigma(context, 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: InkWell(
                splashColor: MyColors.myBlue,
                borderRadius: BorderRadius.circular(15),
                onTap: () async {
                  context
                      .read<ProductBloc>()
                      .add(ProductAddToBasket(product: product));
                  await Future.delayed(
                    const Duration(milliseconds: 100),
                  );
                  context.read<BasketBloc>().add(BasketFetchFromHive());
                  await Future.delayed(
                    const Duration(milliseconds: 100),
                  );
                  context.read<BasketCubit>().updateBasketItems();
                },
                child: Container(
                  width: Responsive.scaleFromFigma(context, 160),
                  height: Responsive.scaleFromFigma(context, 53),
                  decoration: BoxDecoration(
                    backgroundBlendMode: BlendMode.overlay,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white, width: 1),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/background_button.png',
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'افزودن به سبد خرید',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: Responsive.scaleFromFigma(context, 16),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          width: Responsive.scaleFromFigma(context, 140),
          height: Responsive.scaleFromFigma(context, 47),
          decoration: BoxDecoration(
            color: MyColors.myGreen,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          top: Responsive.scaleFromFigma(context, 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: Responsive.scaleFromFigma(context, 160),
                height: Responsive.scaleFromFigma(context, 53),
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.overlay,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white, width: 1),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/background_button.png',
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Responsive.scaleFromFigma(context, 10),
                    ),
                    Text(
                      'تومان',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: Responsive.scaleFromFigma(context, 12),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: Responsive.scaleFromFigma(context, 5),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.price.formatPrice,
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white,
                            decorationThickness: 2,
                            fontFamily: 'SM',
                            fontSize: Responsive.scaleFromFigma(context, 12),
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          product.realPrice.formatPrice,
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: Responsive.scaleFromFigma(context, 16),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Responsive.scaleFromFigma(context, 5),
                    ),
                    Flexible(
                      child: Container(
                        width: Responsive.scaleFromFigma(context, 25),
                        height: Responsive.scaleFromFigma(context, 15),
                        decoration: BoxDecoration(
                          color: MyColors.myRed,
                          borderRadius: BorderRadius.circular(
                              Responsive.scaleFromFigma(context, 7.5)),
                        ),
                        child: Center(
                          child: Text(
                            '%${product.persent.round()}',
                            style: TextStyle(
                              fontFamily: 'SB',
                              color: Colors.white,
                              fontSize: Responsive.scaleFromFigma(context, 10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Responsive.scaleFromFigma(context, 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ColorVariantList extends StatefulWidget {
  const ColorVariantList({
    super.key,
    required this.variantList,
  });
  final List<Variant> variantList;

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.scaleFromFigma(context, 26),
      child: ListView.builder(
        itemCount: widget.variantList.length,
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              margin:
                  EdgeInsets.only(left: Responsive.scaleFromFigma(context, 10)),
              width: index == selectedColor
                  ? Responsive.scaleFromFigma(context, 77)
                  : Responsive.scaleFromFigma(context, 26),
              height: Responsive.scaleFromFigma(context, 26),
              decoration: BoxDecoration(
                border: Border.all(
                  width: index == selectedColor ? 2 : 0,
                  color: MyColors.myBlue,
                ),
                borderRadius: BorderRadius.circular(
                    Responsive.scaleFromFigma(context, 8)),
                color: widget.variantList[index].value.parseToColor,
              ),
              child: AnimatedScale(
                scale: selectedColor == index ? 1 : 0,
                duration: const Duration(
                  milliseconds: 500,
                ),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.variantList[index].name,
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: Responsive.scaleFromFigma(context, 12),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  const StorageVariantList({
    super.key,
    required this.variantList,
  });
  final List<Variant> variantList;

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int selectedStorage = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.scaleFromFigma(context, 26),
      child: ListView.builder(
        itemCount: widget.variantList.length,
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedStorage = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              margin:
                  EdgeInsets.only(left: Responsive.scaleFromFigma(context, 10)),
              width: Responsive.scaleFromFigma(context, 74),
              height: Responsive.scaleFromFigma(context, 26),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(
                  width: selectedStorage == index ? 2 : 0.5,
                  color: selectedStorage == index
                      ? MyColors.myBlue
                      : MyColors.myGrey,
                ),
              ),
              child: Center(
                child: Text(
                  widget.variantList[index].value,
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: Responsive.scaleFromFigma(context, 12),
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
