import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/util/responsive.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomScrollView(
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
                        'سبد خرید',
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 3,
                (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: Responsive.scaleFromFigma(context, 20)),
                    child: const CardBasketitem(),
                  );
                },
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                  bottom: Responsive.scaleFromFigma(context, 180)),
            )
          ],
        ),
        Positioned(
          bottom: Responsive.scaleFromFigma(context, 95),
          right: Responsive.scaleFromFigma(context, 44),
          left: Responsive.scaleFromFigma(context, 44),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize:
                  Size.fromHeight(Responsive.scaleFromFigma(context, 53)),
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
                fontSize: Responsive.scaleFromFigma(context, 16),
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.scaleFromFigma(context, 44)),
      child: Container(
        height: Responsive.scaleFromFigma(context, 239),
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
          padding: EdgeInsets.only(top: Responsive.scaleFromFigma(context, 17)),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Responsive.scaleFromFigma(context, 10),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            textDirection: TextDirection.rtl,
                            'آیفون ۱۳ پرومکس دوسیم کارت',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: Responsive.scaleFromFigma(context, 16),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: Responsive.scaleFromFigma(context, 10),
                          ),
                          Text(
                            textDirection: TextDirection.rtl,
                            'گارانتی 18 ماه مدیا پردازش',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: Responsive.scaleFromFigma(context, 10),
                              color: MyColors.myGrey,
                            ),
                          ),
                          SizedBox(
                            height: Responsive.scaleFromFigma(context, 10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: Responsive.scaleFromFigma(context, 25),
                                height: Responsive.scaleFromFigma(context, 15),
                                decoration: BoxDecoration(
                                  color: MyColors.myRed,
                                  borderRadius: BorderRadius.circular(7.5),
                                ),
                                child: Center(
                                  child: Text(
                                    '%۳',
                                    style: TextStyle(
                                      fontFamily: 'SB',
                                      color: Colors.white,
                                      fontSize: Responsive.scaleFromFigma(
                                          context, 10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Responsive.scaleFromFigma(context, 5),
                              ),
                              Text(
                                textDirection: TextDirection.rtl,
                                'تومان',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize:
                                      Responsive.scaleFromFigma(context, 10),
                                  color: MyColors.myGrey,
                                ),
                              ),
                              SizedBox(
                                width: Responsive.scaleFromFigma(context, 5),
                              ),
                              Text(
                                textDirection: TextDirection.rtl,
                                '۴۶٬۰۰۰٬۰۰۰',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize:
                                      Responsive.scaleFromFigma(context, 10),
                                  color: MyColors.myGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Responsive.scaleFromFigma(context, 10),
                          ),
                          Wrap(
                            textDirection: TextDirection.rtl,
                            runSpacing: Responsive.scaleFromFigma(context, 10),
                            spacing: Responsive.scaleFromFigma(context, 10),
                            children: [
                              Container(
                                width: Responsive.scaleFromFigma(context, 94),
                                height: Responsive.scaleFromFigma(context, 24),
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
                                      width: Responsive.scaleFromFigma(
                                          context, 10),
                                    ),
                                    Icon(
                                      IconsaxOutline.arrow_swap_horizontal,
                                      size: Responsive.scaleFromFigma(
                                          context, 11),
                                      color: MyColors.myGrey,
                                    ),
                                    const Spacer(),
                                    Text(
                                      textDirection: TextDirection.rtl,
                                      '256 گیگابایت',
                                      style: TextStyle(
                                        fontFamily: 'SM',
                                        fontSize: Responsive.scaleFromFigma(
                                            context, 10),
                                        color: MyColors.myGrey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Responsive.scaleFromFigma(
                                          context, 10),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: Responsive.scaleFromFigma(context, 108),
                                height: Responsive.scaleFromFigma(context, 24),
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
                                      width: Responsive.scaleFromFigma(
                                          context, 10),
                                    ),
                                    Icon(
                                      IconsaxOutline.arrow_swap_horizontal,
                                      size: Responsive.scaleFromFigma(
                                          context, 11),
                                      color: MyColors.myGrey,
                                    ),
                                    const Spacer(),
                                    Text(
                                      textDirection: TextDirection.rtl,
                                      'سبز کله غازی',
                                      style: TextStyle(
                                        fontFamily: 'SM',
                                        fontSize: Responsive.scaleFromFigma(
                                            context, 10),
                                        color: MyColors.myGrey,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          Responsive.scaleFromFigma(context, 5),
                                    ),
                                    Container(
                                      width: Responsive.scaleFromFigma(
                                          context, 10),
                                      height: Responsive.scaleFromFigma(
                                          context, 10),
                                      decoration: const ShapeDecoration(
                                          color: MyColors.myBlue,
                                          shape: CircleBorder()),
                                    ),
                                    SizedBox(
                                      width: Responsive.scaleFromFigma(
                                          context, 10),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: Responsive.scaleFromFigma(context, 45),
                                height: Responsive.scaleFromFigma(context, 24),
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
                                      width: Responsive.scaleFromFigma(
                                          context, 10),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          IconsaxBold.arrow_up_1,
                                          size: Responsive.scaleFromFigma(
                                              context, 8),
                                          color: MyColors.myGrey,
                                        ),
                                        Icon(
                                          IconsaxBold.arrow_down,
                                          size: Responsive.scaleFromFigma(
                                              context, 8),
                                          color: MyColors.myGrey,
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      textDirection: TextDirection.rtl,
                                      '1',
                                      style: TextStyle(
                                        fontFamily: 'SM',
                                        fontSize: Responsive.scaleFromFigma(
                                            context, 10),
                                        color: MyColors.myGrey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Responsive.scaleFromFigma(
                                          context, 10),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: Responsive.scaleFromFigma(context, 69),
                                height: Responsive.scaleFromFigma(context, 24),
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
                                      width: Responsive.scaleFromFigma(
                                          context, 10),
                                    ),
                                    Text(
                                      textDirection: TextDirection.rtl,
                                      'ذخیره',
                                      style: TextStyle(
                                        fontFamily: 'SM',
                                        fontSize: Responsive.scaleFromFigma(
                                            context, 10),
                                        color: MyColors.myGrey,
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      IconsaxBold.heart_circle,
                                      color: MyColors.myBlue,
                                      size: Responsive.scaleFromFigma(
                                          context, 17),
                                    ),
                                    SizedBox(
                                      width: Responsive.scaleFromFigma(
                                          context, 10),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: Responsive.scaleFromFigma(context, 62),
                                height: Responsive.scaleFromFigma(context, 24),
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
                                      width: Responsive.scaleFromFigma(
                                          context, 10),
                                    ),
                                    Text(
                                      textDirection: TextDirection.rtl,
                                      'حذف',
                                      style: TextStyle(
                                        fontFamily: 'SM',
                                        fontSize: Responsive.scaleFromFigma(
                                            context, 10),
                                        color: MyColors.myGrey,
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      IconsaxBold.trash,
                                      color: MyColors.myGrey,
                                      size: Responsive.scaleFromFigma(
                                          context, 15),
                                    ),
                                    SizedBox(
                                      width: Responsive.scaleFromFigma(
                                          context, 10),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Responsive.scaleFromFigma(context, 18),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/iphone.png',
                          width: Responsive.scaleFromFigma(context, 79),
                          height: Responsive.scaleFromFigma(context, 104),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Responsive.scaleFromFigma(context, 10),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Responsive.scaleFromFigma(context, 10),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.scaleFromFigma(context, 10)),
                child: DottedLine(
                  dashColor: MyColors.myWhite,
                  lineThickness: Responsive.scaleFromFigma(context, 3),
                  dashLength: Responsive.scaleFromFigma(context, 8),
                  dashGapLength: Responsive.scaleFromFigma(context, 3),
                ),
              ),
              SizedBox(
                height: Responsive.scaleFromFigma(context, 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textDirection: TextDirection.rtl,
                    ' تومان',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: Responsive.scaleFromFigma(context, 12),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: Responsive.scaleFromFigma(context, 5),
                  ),
                  Text(
                    textDirection: TextDirection.rtl,
                    '۴۵٬۳۵۰٬۰۰۰',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: Responsive.scaleFromFigma(context, 16),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.scaleFromFigma(context, 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
