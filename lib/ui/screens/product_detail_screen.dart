import 'dart:ui';

import 'package:apple_shop/bloc/product/bloc/product_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/models/product_image.dart';
import 'package:apple_shop/models/product_variant.dart';
import 'package:apple_shop/models/variant.dart';
import 'package:apple_shop/models/variant_type.dart';
import 'package:apple_shop/util/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                if (state is ProductInitial || state is ProductLoading) ...[
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
                if (state is ProductResponse) ...[
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
                              widget.product.name,
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
                      'SE 2022 آیفون  ',
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
                      return GalleryWidget(productImageList: productImageList);
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
                      height: Responsive.scaleFromFigma(context, 20),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.scaleFromFigma(context, 44)),
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
                              Text(
                                ':مشخصات فنی ',
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
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.scaleFromFigma(context, 20),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.scaleFromFigma(context, 44)),
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
                              Text(
                                ':توضیحات محصول ',
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
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.scaleFromFigma(context, 20),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.scaleFromFigma(context, 44)),
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
                                    width:
                                        Responsive.scaleFromFigma(context, 26),
                                    height:
                                        Responsive.scaleFromFigma(context, 26),
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
                                    right:
                                        Responsive.scaleFromFigma(context, 18),
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
                                    right:
                                        Responsive.scaleFromFigma(context, 36),
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
                                    right:
                                        Responsive.scaleFromFigma(context, 54),
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
                                    right:
                                        Responsive.scaleFromFigma(context, 72),
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
                                            fontSize: Responsive.scaleFromFigma(
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
                          const PriceTagButton(),
                          SizedBox(
                            width: Responsive.scaleFromFigma(context, 44),
                          ),
                          const AddToBasketButton(),
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
              ],
            );
          },
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
          horizontal: Responsive.scaleFromFigma(context, 44)),
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
  });
  final List<ProductImage> productImageList;

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
                        key: Key(widget.productImageList[selectedImage].image),
                        child: CachedNetworkImage(
                          imageUrl:
                              widget.productImageList[selectedImage].image,
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
                itemCount: widget.productImageList.length,
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
                          imageUrl: widget.productImageList[index].image,
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
  const AddToBasketButton({super.key});

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
        )
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({super.key});

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
                          '۴۶٬۰۰۰٬۰۰۰',
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
                          '۱۶٬۹۸۹٬۰۰۰',
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
                    Container(
                      width: Responsive.scaleFromFigma(context, 25),
                      height: Responsive.scaleFromFigma(context, 15),
                      decoration: BoxDecoration(
                        color: MyColors.myRed,
                        borderRadius: BorderRadius.circular(
                            Responsive.scaleFromFigma(context, 7.5)),
                      ),
                      child: Center(
                        child: Text(
                          '%۳',
                          style: TextStyle(
                            fontFamily: 'SB',
                            color: Colors.white,
                            fontSize: Responsive.scaleFromFigma(context, 10),
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
                color: Color(int.parse('FF${widget.variantList[index].value}',
                    radix: 16)),
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
                      color: MyColors.myGrey,
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
            child: Container(
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
