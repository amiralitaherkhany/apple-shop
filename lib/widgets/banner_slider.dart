import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(viewportFraction: 0.8);
    return SizedBox(
      height: 177,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: 340,
                  height: 177,
                  color: Colors.red,
                ),
              );
            },
          ),
          Positioned(
            bottom: 8,
            child: SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: const ExpandingDotsEffect(
                expansionFactor: 5,
                activeDotColor: MyColors.myBlue,
                dotColor: Colors.white,
                dotHeight: 5,
                dotWidth: 5,
                spacing: 2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
