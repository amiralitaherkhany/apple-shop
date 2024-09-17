import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: LoadingAnimationWidget.inkDrop(color: MyColors.myBlue, size: 40),
      ),
    );
  }
}
