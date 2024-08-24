import 'package:apple_shop/constants/colors.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
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
                            'سبد خرید',
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16,
                              color: MyColors.myBlue,
                            ),
                          ),
                          Positioned(
                            left: 15,
                            top: 10,
                            child: Image.asset(
                              'assets/images/icon_apple_blue.png',
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 3,
                    (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: CardBasketitem(),
                      );
                    },
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 70),
                )
              ],
            ),
            Positioned(
              bottom: 20,
              right: 44,
              left: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(53),
                  backgroundColor: MyColors.myGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'ادامه فرآیند خرید',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 44),
      child: Container(
        height: 239,
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
          padding: const EdgeInsets.only(top: 17.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            textDirection: TextDirection.rtl,
                            'آیفون ۱۳ پرومکس دوسیم کارت',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            textDirection: TextDirection.rtl,
                            'گارانتی 18 ماه مدیا پردازش',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 10,
                              color: MyColors.myGrey,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
                                width: 5,
                              ),
                              const Text(
                                textDirection: TextDirection.rtl,
                                'تومان',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 10,
                                  color: MyColors.myGrey,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                textDirection: TextDirection.rtl,
                                '۴۶٬۰۰۰٬۰۰۰',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 10,
                                  color: MyColors.myGrey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            textDirection: TextDirection.rtl,
                            runSpacing: 10,
                            spacing: 3,
                            children: [
                              Container(
                                width: 94,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xffE5E5E5),
                                    width: 1,
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      IconsaxOutline.arrow_swap_horizontal,
                                      size: 11,
                                      color: MyColors.myGrey,
                                    ),
                                    Spacer(),
                                    Text(
                                      textDirection: TextDirection.rtl,
                                      '256 گیگابایت',
                                      style: TextStyle(
                                        fontFamily: 'SM',
                                        fontSize: 10,
                                        color: MyColors.myGrey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 108,
                                height: 24,
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
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      IconsaxOutline.arrow_swap_horizontal,
                                      size: 11,
                                      color: MyColors.myGrey,
                                    ),
                                    const Spacer(),
                                    const Text(
                                      textDirection: TextDirection.rtl,
                                      'سبز کله غازی',
                                      style: TextStyle(
                                        fontFamily: 'SM',
                                        fontSize: 10,
                                        color: MyColors.myGrey,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const ShapeDecoration(
                                          color: MyColors.myBlue,
                                          shape: CircleBorder()),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 45,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xffE5E5E5),
                                    width: 1,
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          IconsaxBold.arrow_up_1,
                                          size: 11,
                                          color: MyColors.myGrey,
                                        ),
                                        Icon(
                                          IconsaxBold.arrow_down,
                                          size: 11,
                                          color: MyColors.myGrey,
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      textDirection: TextDirection.rtl,
                                      '1',
                                      style: TextStyle(
                                        fontFamily: 'SM',
                                        fontSize: 10,
                                        color: MyColors.myGrey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 69,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xffE5E5E5),
                                    width: 1,
                                  ),
                                ),
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      textDirection: TextDirection.rtl,
                                      'ذخیره',
                                      style: TextStyle(
                                        fontFamily: 'SM',
                                        fontSize: 10,
                                        color: MyColors.myGrey,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      IconsaxBold.heart_circle,
                                      color: MyColors.myBlue,
                                      size: 17,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 62,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xffE5E5E5),
                                    width: 1,
                                  ),
                                ),
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      textDirection: TextDirection.rtl,
                                      'حذف',
                                      style: TextStyle(
                                        fontFamily: 'SM',
                                        fontSize: 10,
                                        color: MyColors.myGrey,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      IconsaxBold.trash,
                                      color: MyColors.myGrey,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/iphone.png',
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: DottedLine(
                  dashColor: MyColors.myWhite,
                  lineThickness: 3,
                  dashLength: 8,
                  dashGapLength: 3,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textDirection: TextDirection.rtl,
                    ' تومان',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    textDirection: TextDirection.rtl,
                    '۴۵٬۳۵۰٬۰۰۰',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
