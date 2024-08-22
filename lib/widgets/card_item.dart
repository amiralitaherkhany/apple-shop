import 'package:apple_shop/constants/colors.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: index == 0 ? 44 : 0),
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
              Image.asset('assets/images/iphone.png'),
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
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'آیفون 13 پرو مکس',
                style: TextStyle(
                  fontFamily: 'SB',
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 53,
            decoration: const BoxDecoration(
              color: MyColors.myBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2.77),
                  blurRadius: 2.21,
                  spreadRadius: 0,
                  color: Color.fromRGBO(59, 94, 223, 0.06),
                ),
                BoxShadow(
                  offset: Offset(0, 6.65),
                  blurRadius: 5.32,
                  spreadRadius: 0,
                  color: Color.fromRGBO(59, 94, 223, 0.06),
                ),
                BoxShadow(
                  offset: Offset(0, 12.52),
                  blurRadius: 10.02,
                  spreadRadius: 0,
                  color: Color.fromRGBO(59, 94, 223, 0.07),
                ),
                BoxShadow(
                  offset: Offset(0, 22.34),
                  blurRadius: 17.87,
                  spreadRadius: 0,
                  color: Color.fromRGBO(59, 94, 223, 0.07),
                ),
                BoxShadow(
                  offset: Offset(0, 41.78),
                  blurRadius: 33.42,
                  spreadRadius: 0,
                  color: Color.fromRGBO(59, 94, 223, 0.07),
                ),
                BoxShadow(
                  offset: Offset(0, 100),
                  blurRadius: 80,
                  spreadRadius: 0,
                  color: Color.fromRGBO(59, 94, 223, 0.09),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'تومان',
                  style: TextStyle(
                    fontFamily: 'SM',
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 5,
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
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '۴۵٬۳۵۰٬۰۰۰',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 12,
                ),
                Icon(
                  IconsaxBold.arrow_right,
                  color: MyColors.myWhite,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
