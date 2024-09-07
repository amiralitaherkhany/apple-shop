import 'dart:ui';

import 'package:apple_shop/bloc/product/bloc/product_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/models/product_image.dart';
import 'package:apple_shop/models/product_property.dart';
import 'package:apple_shop/models/product_variant.dart';
import 'package:apple_shop/models/variant.dart';
import 'package:apple_shop/models/variant_type.dart';
import 'package:apple_shop/util/extensions/string_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                      height: 10.h,
                    ),
                  ),
                  SliverAppBar(
                    automaticallyImplyLeading: false,
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
                            Positioned(
                              right: 5.w,
                              child: IconButton(
                                iconSize: 30.w,
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
                      height: 22.h,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      textAlign: TextAlign.center,
                      widget.product.name,
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20.h,
                    ),
                  ),
                  state.productImageList.fold(
                    (exception) {
                      return SliverToBoxAdapter(child: Text(exception));
                    },
                    (productImageList) {
                      return GalleryWidget(
                        productImageList: productImageList,
                        defaultProductThumbnail: widget.product.thumbnail,
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20.h,
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
                      height: 10.h,
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
                      height: 20.h,
                    ),
                  ),
                  ProductDescription(
                    productDescription: widget.product.description,
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20.h,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 44.w),
                      child: Container(
                        height: 46.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MyColors.myGrey,
                            width: 1,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            children: [
                              const Icon(
                                IconsaxOutline.arrow_circle_left,
                                color: MyColors.myBlue,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'مشاهده',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12.sp,
                                  color: MyColors.myBlue,
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 26.w,
                                    height: 26.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Colors.red,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 18.w,
                                    child: Container(
                                      width: 26.w,
                                      height: 26.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Colors.green,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 36.w,
                                    child: Container(
                                      width: 26.w,
                                      height: 26.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Colors.yellow,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 54.w,
                                    child: Container(
                                      width: 26.w,
                                      height: 26.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Colors.blue,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 72.w,
                                    child: Container(
                                      width: 26.w,
                                      height: 26.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
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
                                            fontSize: 10.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                ':نظرات کاربران',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12.sp,
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
                      height: 38.h,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 44.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const PriceTagButton(),
                          SizedBox(
                            width: 44.w,
                          ),
                          AddToBasketButton(
                            product: widget.product,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 32.h,
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
        padding: EdgeInsets.symmetric(horizontal: 44.w),
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
            tilePadding: EdgeInsets.symmetric(horizontal: 10.w),
            childrenPadding: EdgeInsets.all(16.r),
            minTileHeight: 46.h,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'مشاهده',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 12.sp,
                    color: MyColors.myBlue,
                  ),
                ),
                SizedBox(
                  width: 10.w,
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
              borderRadius: BorderRadius.circular(15.r),
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: MyColors.myGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15.r),
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
                fontSize: 12.sp,
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
                      fontSize: 14.sp,
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
        padding: EdgeInsets.symmetric(horizontal: 44.w),
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
            tilePadding: EdgeInsets.symmetric(horizontal: 10.w),
            childrenPadding: EdgeInsets.all(16.r),
            minTileHeight: 46.h,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'مشاهده',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 12.sp,
                    color: MyColors.myBlue,
                  ),
                ),
                SizedBox(
                  width: 10.w,
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
                fontSize: 12.sp,
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
                  fontSize: 14.sp,
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
      padding: EdgeInsets.symmetric(horizontal: 44.w, vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title,
            style: TextStyle(
              fontFamily: 'SB',
              fontSize: 12.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10.h,
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
        height: 284.h,
        margin: EdgeInsets.symmetric(horizontal: 44.w),
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
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Center(
                        key: UniqueKey(),
                        child: CachedNetworkImage(
                          width: 150.w,
                          height: 150.h,
                          imageUrl: widget.productImageList.isEmpty
                              ? widget.defaultProductThumbnail
                              : widget.productImageList[selectedImage].image,
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/no-image-icon-6.png',
                            width: 150.w,
                            height: 150.h,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.h,
                      left: 5.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            IconsaxBold.star,
                            color: const Color(0xffFFBF00),
                            size: 28.w,
                          ),
                          Text(
                            '4.6',
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10.h,
                      right: 5.w,
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
              height: 70.h,
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
                        left: 20.w,
                        right: index == 0 ? 35.w : 0,
                      ),
                      padding: EdgeInsets.all(10.r),
                      width: 70.w,
                      height: 70.h,
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
              height: 30.h,
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
          width: 140.w,
          height: 47.h,
          decoration: BoxDecoration(
            color: MyColors.myBlue,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          top: 5.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: InkWell(
                onTap: () {
                  context
                      .read<ProductBloc>()
                      .add(ProductAddToBasket(product: product));
                },
                child: Container(
                  width: 160.w,
                  height: 53.h,
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
                        fontSize: 16.sp,
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
  const PriceTagButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          width: 140.w,
          height: 47.h,
          decoration: BoxDecoration(
            color: MyColors.myGreen,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          top: 5.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: 160.w,
                height: 53.h,
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
                      width: 10.w,
                    ),
                    Text(
                      'تومان',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
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
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '۱۶٬۹۸۹٬۰۰۰',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Container(
                      width: 25.w,
                      height: 15.h,
                      decoration: BoxDecoration(
                        color: MyColors.myRed,
                        borderRadius: BorderRadius.circular(7.5.r),
                      ),
                      child: Center(
                        child: Text(
                          '%۳',
                          style: TextStyle(
                            fontFamily: 'SB',
                            color: Colors.white,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
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
      height: 26.h,
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
              margin: EdgeInsets.only(left: 10.w),
              width: index == selectedColor ? 77.w : 26.w,
              height: 26.h,
              decoration: BoxDecoration(
                border: Border.all(
                  width: index == selectedColor ? 2 : 0,
                  color: MyColors.myBlue,
                ),
                borderRadius: BorderRadius.circular(8.r),
                color: widget.variantList[index].value.parseToColor(),
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
                      fontSize: 12.sp,
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
      height: 26.h,
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
              margin: EdgeInsets.only(left: 10.w),
              width: 74.w,
              height: 26.h,
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
                    fontSize: 12.sp,
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
