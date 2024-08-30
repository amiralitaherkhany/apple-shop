import 'package:apple_shop/bloc/product/bloc/product_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:apple_shop/util/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    int realPrice = product.price - product.discountPrice;
    String percent =
        '%${(((product.price - realPrice) * 100) / product.price).round()}';
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProductBloc()..add(ProductInitialize()),
            child: ProductDetailScreen(
              product: product,
            ),
          ),
        ));
      },
      child: Container(
        width: Responsive.scaleFromFigma(context, 160),
        height: Responsive.scaleFromFigma(context, 216),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            SizedBox(
              height: Responsive.scaleFromFigma(context, 10),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                const Center(),
                CachedNetworkImage(
                  width: Responsive.scaleFromFigma(context, 100),
                  height: Responsive.scaleFromFigma(context, 100),
                  imageUrl: product.thumbnail,
                  errorListener: (value) => print(value.toString()),
                  errorWidget: (context, url, error) {
                    return Image.asset('assets/images/no-image-icon-6.png');
                  },
                ),
                const Positioned(
                  top: 0,
                  right: 10,
                  child: Icon(
                    IconsaxBold.heart_circle,
                    color: MyColors.myBlue,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    width: Responsive.scaleFromFigma(context, 25),
                    height: Responsive.scaleFromFigma(context, 15),
                    decoration: BoxDecoration(
                      color: MyColors.myRed,
                      borderRadius: BorderRadius.circular(
                          Responsive.scaleFromFigma(context, 7.5)),
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            percent,
                            style: TextStyle(
                              fontFamily: 'SB',
                              color: Colors.white,
                              fontSize: Responsive.scaleFromFigma(context, 10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: Responsive.scaleFromFigma(context, 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  maxLines: 1,
                  product.name,
                  style: TextStyle(
                    fontFamily: 'SB',
                    color: Colors.black,
                    fontSize: Responsive.scaleFromFigma(context, 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: Responsive.scaleFromFigma(context, 10),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: Responsive.scaleFromFigma(context, 53),
              decoration: BoxDecoration(
                color: MyColors.myBlue,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B5EDF).withOpacity(0.0335),
                    offset: const Offset(0, 2.77),
                    blurRadius: 2.21,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: const Color(0xFF3B5EDF).withOpacity(0.0412),
                    offset: const Offset(0, 6.65),
                    blurRadius: 5.32,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: const Color(0xFF3B5EDF).withOpacity(0.0455),
                    offset: const Offset(0, 12.52),
                    blurRadius: 10.02,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: const Color(0xFF3B5EDF).withOpacity(0.0491),
                    offset: const Offset(0, 22.34),
                    blurRadius: 17.87,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: const Color(0xFF3B5EDF).withOpacity(0.0541),
                    offset: const Offset(0, 41.78),
                    blurRadius: 33.42,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: const Color(0xFF3B5EDF).withOpacity(0.07),
                    offset: const Offset(0, 100),
                    blurRadius: 80,
                    spreadRadius: 0,
                  ),
                ],
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
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          product.price.toString(),
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white,
                            decorationThickness: 2,
                            fontFamily: 'SM',
                            fontSize: Responsive.scaleFromFigma(context, 12),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          realPrice.toString(),
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: Responsive.scaleFromFigma(context, 16),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    IconsaxBold.arrow_right,
                    color: MyColors.myWhite,
                  ),
                  SizedBox(
                    width: Responsive.scaleFromFigma(context, 15),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
