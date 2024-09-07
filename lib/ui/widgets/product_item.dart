import 'package:apple_shop/bloc/product/bloc/product_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/ui/screens/product_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProductBloc()
              ..add(ProductInitialize(
                  productId: product.id, categoryId: product.categoryId)),
            child: ProductDetailScreen(
              product: product,
            ),
          ),
        ));
      },
      child: Container(
        width: 160.w,
        height: 216.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                const Center(),
                CachedNetworkImage(
                  width: 100.w,
                  height: 100.w,
                  imageUrl: product.thumbnail,
                  errorListener: (value) {},
                  errorWidget: (context, url, error) {
                    return Image.asset('assets/images/no-image-icon-6.png');
                  },
                ),
                Positioned(
                  top: 0,
                  right: 10.w,
                  child: Icon(
                    IconsaxBold.heart_circle,
                    color: MyColors.myBlue,
                    size: 21.w,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 10.w,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    width: 25.w,
                    height: 15.h,
                    decoration: BoxDecoration(
                      color: MyColors.myRed,
                      borderRadius: BorderRadius.circular(7.5.r),
                    ),
                    child: Center(
                      child: Text(
                        '%${product.persent.round()}',
                        style: TextStyle(
                          fontFamily: 'SB',
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
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
                    fontSize: 14.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 53.h,
              decoration: BoxDecoration(
                color: MyColors.myBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
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
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          product.price.toString(),
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white,
                            decorationThickness: 2.h,
                            fontFamily: 'SM',
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          product.realPrice.toString(),
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    IconsaxBold.arrow_right,
                    color: MyColors.myWhite,
                    size: 30.w,
                  ),
                  SizedBox(
                    width: 15.w,
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
