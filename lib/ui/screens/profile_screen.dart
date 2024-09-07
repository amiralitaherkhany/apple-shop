import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 44.w),
          child: Container(
            width: 340.w,
            height: 46.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.white,
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Text(
                  'حساب کاربری',
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
        SizedBox(
          height: 32.h,
        ),
        Text(
          textAlign: TextAlign.center,
          'امیرعلی طاهرخانی',
          style: TextStyle(
            fontFamily: 'SB',
            fontSize: 16.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          textAlign: TextAlign.center,
          '09942024303',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: 10.sp,
            color: MyColors.myGrey,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 44.w),
          child: Wrap(
            spacing: 38.w,
            runSpacing: 20.h,
            textDirection: TextDirection.rtl,
            children: const [
              SizedBox(
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
            ],
          ),
        ),
        const Spacer(),
        Text(
          textAlign: TextAlign.center,
          'اپل شاپ',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: 10.sp,
            color: MyColors.myGrey,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          textAlign: TextAlign.center,
          'V-1.0.00',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: 10.sp,
            color: MyColors.myGrey,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          textAlign: TextAlign.center,
          'Instagram.com/Mojavad-dev',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: 10.sp,
            color: MyColors.myGrey,
          ),
        ),
        SizedBox(
          height: 107.h,
        ),
      ],
    );
  }
}
