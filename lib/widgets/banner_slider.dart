import 'dart:async';

import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/models/banner.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({
    super.key,
    required this.bannerList,
  });
  final List<BannerModel> bannerList;

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late Timer timer;
  static int currentPage = 0;
  final PageController pageController =
      PageController(viewportFraction: 0.9, initialPage: currentPage);
  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (Timer timer) {
        if (currentPage < widget.bannerList.length - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }
        pageController.animateToPage(currentPage,
            duration: const Duration(seconds: 1), curve: Easing.legacy);
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 177,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: widget.bannerList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      color: Colors.grey,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.red[500],
                    ),
                    imageUrl: widget.bannerList[index].thumbnail!,
                    width: 340,
                    height: 177,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 8,
            child: SmoothPageIndicator(
              controller: pageController,
              count: widget.bannerList.length,
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
