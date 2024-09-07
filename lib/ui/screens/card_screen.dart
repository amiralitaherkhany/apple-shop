import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/models/card_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<BasketItem>('BasketBox');
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomScrollView(
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
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Text(
                        'سبد خرید',
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: box.values.length,
                (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: CardBasketitem(
                      basketItem: box.values.toList()[index],
                    ),
                  );
                },
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 180.h),
            )
          ],
        ),
        Positioned(
          bottom: 95.h,
          right: 44.w,
          left: 44.w,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(53.h),
              backgroundColor: MyColors.myGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {},
            child: Text(
              'ادامه فرآیند خرید',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CardBasketitem extends StatelessWidget {
  const CardBasketitem({
    super.key,
    required this.basketItem,
  });
  final BasketItem basketItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44.w),
      child: Container(
        height: 239.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF858585).withOpacity(0.0368),
              offset: const Offset(0, 2.77),
              blurRadius: 2.21,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: const Color(0xFF858585).withOpacity(0.0445),
              offset: const Offset(0, 4.99),
              blurRadius: 5.32,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: const Color(0xFF858585).withOpacity(0.0482),
              offset: const Offset(0, 12.52),
              blurRadius: 10.02,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: const Color(0xFF858585).withOpacity(0.051),
              offset: const Offset(0, 16.75),
              blurRadius: 17.87,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: const Color(0xFF858585).withOpacity(0.0549),
              offset: const Offset(0, 41.78),
              blurRadius: 33.42,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: const Color(0xFF858585).withOpacity(0.07),
              offset: const Offset(0, 20),
              blurRadius: 80,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 17.h),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            textDirection: TextDirection.rtl,
                            basketItem.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            textDirection: TextDirection.rtl,
                            'گارانتی 18 ماه مدیا پردازش',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 10.sp,
                              color: MyColors.myGrey,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 25.w,
                                height: 15.h,
                                decoration: BoxDecoration(
                                  color: MyColors.myRed,
                                  borderRadius: BorderRadius.circular(7.5),
                                ),
                                child: Center(
                                  child: Text(
                                    '%${basketItem.persent.round()}',
                                    style: TextStyle(
                                      fontFamily: 'SB',
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                textDirection: TextDirection.rtl,
                                'تومان',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 10.sp,
                                  color: MyColors.myGrey,
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                textDirection: TextDirection.rtl,
                                basketItem.price.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 10.sp,
                                  color: MyColors.myGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Wrap(
                            textDirection: TextDirection.rtl,
                            runSpacing: 10.h,
                            spacing: 10.w,
                            children: const [
                              StorageVariantCheap(),
                              ColorVariantCheap(),
                              NumberOfProductCheap(),
                              SaveProductCheap(),
                              DeleteProductCheap(),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.contain,
                          imageUrl: basketItem.thumbnail,
                          width: 79.w,
                          height: 104.h,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: DottedLine(
                  dashColor: MyColors.myWhite,
                  lineThickness: 3.h,
                  dashLength: 8.w,
                  dashGapLength: 3.w,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textDirection: TextDirection.rtl,
                    ' تومان',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    textDirection: TextDirection.rtl,
                    basketItem.realPrice.toString(),
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteProductCheap extends StatelessWidget {
  const DeleteProductCheap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62.w,
      height: 24.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffE5E5E5),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 10.w,
          ),
          Text(
            textDirection: TextDirection.rtl,
            'حذف',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: 10.sp,
              color: MyColors.myGrey,
            ),
          ),
          const Spacer(),
          Icon(
            IconsaxBold.trash,
            color: MyColors.myGrey,
            size: 15.w,
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}

class SaveProductCheap extends StatelessWidget {
  const SaveProductCheap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 69.w,
      height: 24.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffE5E5E5),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 10.w,
          ),
          Text(
            textDirection: TextDirection.rtl,
            'ذخیره',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: 10.sp,
              color: MyColors.myGrey,
            ),
          ),
          const Spacer(),
          Icon(
            IconsaxBold.heart_circle,
            color: MyColors.myBlue,
            size: 17.w,
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}

class NumberOfProductCheap extends StatelessWidget {
  const NumberOfProductCheap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 24.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffE5E5E5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textDirection: TextDirection.rtl,
            '1',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: 10.sp,
              color: MyColors.myGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class ColorVariantCheap extends StatelessWidget {
  const ColorVariantCheap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 108.w,
      height: 24.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffE5E5E5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Icon(
            IconsaxOutline.arrow_swap_horizontal,
            size: 11.w,
            color: MyColors.myGrey,
          ),
          const Spacer(),
          Text(
            textDirection: TextDirection.rtl,
            'سبز کله غازی',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: 10.sp,
              color: MyColors.myGrey,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Container(
            width: 10.w,
            height: 10.h,
            decoration: const ShapeDecoration(
                color: MyColors.myBlue, shape: CircleBorder()),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}

class StorageVariantCheap extends StatelessWidget {
  const StorageVariantCheap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 94.w,
      height: 24.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffE5E5E5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Icon(
            IconsaxOutline.arrow_swap_horizontal,
            size: 11.w,
            color: MyColors.myGrey,
          ),
          const Spacer(),
          Text(
            textDirection: TextDirection.rtl,
            '256 گیگابایت',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: 10.sp,
              color: MyColors.myGrey,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
