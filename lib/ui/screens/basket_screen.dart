import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/payment/payment_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/models/card_item.dart';
import 'package:apple_shop/util/extensions/int_extensions.dart';
import 'package:apple_shop/util/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentResponse) {
          state.response.fold(
            (error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error)));
            },
            (isPaymentSuccess) {
              isPaymentSuccess
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          textAlign: TextAlign.end,
                          'پرداخت موفقیت آمیز بود',
                          style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: Responsive.scaleFromFigma(context, 16),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          textAlign: TextAlign.end,
                          'پرداخت موفقیت آمیز نبود',
                          style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: Responsive.scaleFromFigma(context, 16),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
            },
          );
        }
      },
      child: BlocBuilder<BasketBloc, BasketState>(
        builder: (context, state) {
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
                  if (state is BasketDataFetched) ...{
                    state.basketItems.fold(
                      (exception) {
                        return SliverToBoxAdapter(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                exception,
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize:
                                      Responsive.scaleFromFigma(context, 16),
                                  color: MyColors.myBlue,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      (basketItems) {
                        if (basketItems.isNotEmpty) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: basketItems.length,
                              (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: Responsive.scaleFromFigma(
                                          context, 20)),
                                  child: CardBasketitem(
                                    index: index,
                                    basketItem: basketItems[index],
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return SliverToBoxAdapter(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'سبد خرید شما خالی است',
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize:
                                        Responsive.scaleFromFigma(context, 16),
                                    color: MyColors.myBlue,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  },
                  SliverPadding(
                    padding: EdgeInsets.only(
                        bottom: Responsive.scaleFromFigma(context, 180)),
                  )
                ],
              ),
              if (state is BasketDataFetched) ...{
                Positioned(
                  bottom: Responsive.scaleFromFigma(context, 95),
                  right: Responsive.scaleFromFigma(context, 44),
                  left: Responsive.scaleFromFigma(context, 44),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(
                          Responsive.scaleFromFigma(context, 53)),
                      backgroundColor: MyColors.myGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      context.read<PaymentBloc>().add(PaymentInitEvent());
                      context.read<PaymentBloc>().add(PaymentRequestEvent());
                    },
                    child: Text(
                      textDirection: TextDirection.rtl,
                      state.finalPrice != 0
                          ? '${state.finalPrice.formatPrice}  -  ادامه فرایند خرید '
                          : 'محصولی در سبد خرید نیست',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: Responsive.scaleFromFigma(context, 16),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              },
            ],
          );
        },
      ),
    );
  }
}

class CardBasketitem extends StatelessWidget {
  const CardBasketitem({
    super.key,
    required this.basketItem,
    required this.index,
  });
  final BasketItem basketItem;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.scaleFromFigma(context, 44),
      ),
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
                            basketItem.name,
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
                                    '%${basketItem.persent.round()}',
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
                                basketItem.price.formatPrice,
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
                              const StorageVariantCheap(),
                              const ColorVariantCheap(),
                              const NumberOfProductCheap(),
                              const SaveProductCheap(),
                              DeleteProductCheap(
                                productItemIndex: index,
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
                        CachedNetworkImage(
                          fit: BoxFit.contain,
                          imageUrl: basketItem.thumbnail,
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
                    basketItem.realPrice.formatPrice,
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

class DeleteProductCheap extends StatelessWidget {
  const DeleteProductCheap({
    super.key,
    required this.productItemIndex,
  });
  final int productItemIndex;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<BasketBloc>()
            .add(BasketRemoveProduct(index: productItemIndex));
      },
      child: Container(
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
              width: Responsive.scaleFromFigma(context, 10),
            ),
            Text(
              textDirection: TextDirection.rtl,
              'حذف',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: Responsive.scaleFromFigma(context, 10),
                color: MyColors.myGrey,
              ),
            ),
            const Spacer(),
            Icon(
              IconsaxBold.trash,
              color: MyColors.myGrey,
              size: Responsive.scaleFromFigma(context, 15),
            ),
            SizedBox(
              width: Responsive.scaleFromFigma(context, 10),
            ),
          ],
        ),
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
            width: Responsive.scaleFromFigma(context, 10),
          ),
          Text(
            textDirection: TextDirection.rtl,
            'ذخیره',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: Responsive.scaleFromFigma(context, 10),
              color: MyColors.myGrey,
            ),
          ),
          const Spacer(),
          Icon(
            IconsaxBold.heart_circle,
            color: MyColors.myBlue,
            size: Responsive.scaleFromFigma(context, 17),
          ),
          SizedBox(
            width: Responsive.scaleFromFigma(context, 10),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textDirection: TextDirection.rtl,
            '1',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: Responsive.scaleFromFigma(context, 10),
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
            width: Responsive.scaleFromFigma(context, 10),
          ),
          Icon(
            IconsaxOutline.arrow_swap_horizontal,
            size: Responsive.scaleFromFigma(context, 11),
            color: MyColors.myGrey,
          ),
          const Spacer(),
          Text(
            textDirection: TextDirection.rtl,
            'سبز کله غازی',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: Responsive.scaleFromFigma(context, 10),
              color: MyColors.myGrey,
            ),
          ),
          SizedBox(
            width: Responsive.scaleFromFigma(context, 5),
          ),
          Container(
            width: Responsive.scaleFromFigma(context, 10),
            height: Responsive.scaleFromFigma(context, 10),
            decoration: const ShapeDecoration(
                color: MyColors.myBlue, shape: CircleBorder()),
          ),
          SizedBox(
            width: Responsive.scaleFromFigma(context, 10),
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
            width: Responsive.scaleFromFigma(context, 10),
          ),
          Icon(
            IconsaxOutline.arrow_swap_horizontal,
            size: Responsive.scaleFromFigma(context, 11),
            color: MyColors.myGrey,
          ),
          const Spacer(),
          Text(
            textDirection: TextDirection.rtl,
            '256 گیگابایت',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: Responsive.scaleFromFigma(context, 10),
              color: MyColors.myGrey,
            ),
          ),
          SizedBox(
            width: Responsive.scaleFromFigma(context, 10),
          ),
        ],
      ),
    );
  }
}
