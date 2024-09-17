import 'package:flutter/widgets.dart';

class Responsive {
  static double scaleFromFigma(BuildContext context, double figmaSize,
      {double figmaWidth = 428.0, double figmaHeight = 926.0}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final widthRatio = screenWidth / figmaWidth;
    final heightRatio = screenHeight / figmaHeight;

    final scaleRatio = widthRatio < heightRatio ? widthRatio : heightRatio;

    return figmaSize * scaleRatio;
  }
}
