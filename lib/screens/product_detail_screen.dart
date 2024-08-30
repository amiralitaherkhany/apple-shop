import 'dart:ui';

import 'package:apple_shop/bloc/product/bloc/product_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/models/product_image.dart';
import 'package:apple_shop/models/variant_type.dart';
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
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverAppBar(
                    automaticallyImplyLeading: false,
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
                            Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontFamily: 'SB',
                                fontSize: 16,
                                color: MyColors.myBlue,
                              ),
                            ),
                            Positioned(
                              left: 15,
                              top: 10,
                              child: Image.asset(
                                  'assets/images/icon_apple_blue.png'),
                            ),
                            Positioned(
                              right: 5,
                              child: IconButton(
                                iconSize: 30,
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
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 32,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Text(
                      textAlign: TextAlign.center,
                      'SE 2022 آیفون  ',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
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
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  state.productVariantList.fold(
                    (exception) {
                      return SliverToBoxAdapter(child: Text(exception));
                    },
                    (productVariantList) {
                      for (var productVariant in productVariantList) {
                        print(productVariant.variantType.title);
                        for (var variantObject in productVariant.variantList) {
                          print(variantObject.name);
                        }
                      }
                      return const SliverToBoxAdapter(
                        child: Text('data'),
                      );
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 44),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'انتخاب حافظه داخلی',
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 74,
                                height: 26,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.5,
                                    color: MyColors.myGrey,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '128',
                                    style: TextStyle(
                                      fontFamily: 'SB',
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 74,
                                height: 26,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.5,
                                    color: MyColors.myGrey,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '128',
                                    style: TextStyle(
                                      fontFamily: 'SB',
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 74,
                                height: 26,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.5,
                                    color: MyColors.myGrey,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '128',
                                    style: TextStyle(
                                      fontFamily: 'SB',
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 44.0),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MyColors.myGrey,
                            width: 1,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Icon(
                                IconsaxOutline.arrow_circle_left,
                                color: MyColors.myBlue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'مشاهده',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: MyColors.myBlue,
                                ),
                              ),
                              Spacer(),
                              Text(
                                ':مشخصات فنی ',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 44.0),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MyColors.myGrey,
                            width: 1,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Icon(
                                IconsaxOutline.arrow_circle_left,
                                color: MyColors.myBlue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'مشاهده',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: MyColors.myBlue,
                                ),
                              ),
                              Spacer(),
                              Text(
                                ':توضیحات محصول ',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 44.0),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MyColors.myGrey,
                            width: 1,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              const Icon(
                                IconsaxOutline.arrow_circle_left,
                                color: MyColors.myBlue,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'مشاهده',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: MyColors.myBlue,
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.red,
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                    ),
                                  ),
                                  Positioned(
                                    right: 18,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.green,
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 36,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.yellow,
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 54,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue,
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 72,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: MyColors.myGrey,
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '+10',
                                          style: TextStyle(
                                            fontFamily: 'SB',
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                ':نظرات کاربران',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 38,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 44.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PriceTagButton(),
                          AddToBasketButton(),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 32,
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

class ColorVariants extends StatelessWidget {
  const ColorVariants({
    super.key,
    required this.variantType,
  });
  final VariantType variantType;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              variantType.title,
              style: const TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyColors.myRed,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyColors.myRed,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyColors.myRed,
                  ),
                ),
              ],
            )
          ],
        ),
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
        height: 284,
        margin: const EdgeInsets.symmetric(horizontal: 44),
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                    const Positioned(
                      top: 10,
                      left: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            IconsaxBold.star,
                            color: Color(0xffFFBF00),
                            size: 28,
                          ),
                          Text(
                            '4.6',
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      right: 5,
                      child: Icon(
                        IconsaxBold.heart_circle,
                        color: MyColors.myGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 70,
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
                        left: 20,
                        right: index == 0 ? 35 : 0,
                      ),
                      padding: const EdgeInsets.all(10),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: index == selectedImage
                              ? MyColors.myBlue
                              : MyColors.myGrey,
                          width: index == selectedImage ? 3 : 1,
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
            const SizedBox(
              height: 30,
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
          width: 140,
          height: 47,
          decoration: BoxDecoration(
            color: MyColors.myBlue,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          top: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: 160,
                height: 53,
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
                child: const Center(
                  child: Text(
                    'افزودن به سبد خرید',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 16,
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
          width: 140,
          height: 47,
          decoration: BoxDecoration(
            color: MyColors.myGreen,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          top: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: 160,
                height: 53,
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
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'تومان',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Column(
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
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '۱۶٬۹۸۹٬۰۰۰',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 25,
                      height: 15,
                      decoration: BoxDecoration(
                        color: MyColors.myRed,
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: const Center(
                        child: Text(
                          '%۳',
                          style: TextStyle(
                            fontFamily: 'SB',
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
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
