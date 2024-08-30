import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';

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
          builder: (context) => const ProductDetailScreen(),
        ));
      },
      child: Container(
        width: 160,
        height: 216,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                const Center(),
                CachedNetworkImage(
                  width: 100,
                  height: 100,
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
                    width: 25,
                    height: 15,
                    decoration: BoxDecoration(
                      color: MyColors.myRed,
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            percent,
                            style: const TextStyle(
                              fontFamily: 'SB',
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  maxLines: 1,
                  product.name,
                  style: const TextStyle(
                    fontFamily: 'SB',
                    color: Colors.black,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 53,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          product.price.toString(),
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white,
                            decorationThickness: 2,
                            fontFamily: 'SM',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          realPrice.toString(),
                          style: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 16,
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
                  const SizedBox(
                    width: 15,
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
