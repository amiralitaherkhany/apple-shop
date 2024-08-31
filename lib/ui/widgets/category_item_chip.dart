import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/util/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryItemChip extends StatelessWidget {
  const CategoryItemChip({
    super.key,
    required this.category,
  });
  final Category category;
  @override
  Widget build(BuildContext context) {
    int categoryColor = int.parse('FF${category.color!}', radix: 16);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(Responsive.scaleFromFigma(context, 15)),
          width: Responsive.scaleFromFigma(context, 56),
          height: Responsive.scaleFromFigma(context, 56),
          decoration: ShapeDecoration(
            shadows: [
              BoxShadow(
                color: Color(categoryColor).withOpacity(0.0368),
                offset: const Offset(0, 2.77),
                blurRadius: 2.21,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Color(categoryColor).withOpacity(0.0445),
                offset: const Offset(0, 6.65),
                blurRadius: 5.32,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Color(categoryColor).withOpacity(0.0482),
                offset: const Offset(0, 12.52),
                blurRadius: 10.02,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Color(categoryColor).withOpacity(0.051),
                offset: const Offset(0, 22.34),
                blurRadius: 17.87,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Color(categoryColor).withOpacity(0.0549),
                offset: const Offset(0, 41.78),
                blurRadius: 33.42,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Color(categoryColor).withOpacity(0.07),
                offset: const Offset(0, 100),
                blurRadius: 80,
                spreadRadius: 0,
              ),
            ],
            shape: ContinuousRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Responsive.scaleFromFigma(context, 45)),
            ),
            color: Color(categoryColor),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: category.icon!,
            placeholder: (context, url) => Container(
              decoration: ShapeDecoration(
                color: Colors.grey,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              decoration: ShapeDecoration(
                color: Colors.red,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Responsive.scaleFromFigma(context, 10),
        ),
        Text(
          category.title!,
          style: TextStyle(
            fontFamily: 'SB',
            color: Colors.black,
            fontSize: Responsive.scaleFromFigma(context, 12),
          ),
        )
      ],
    );
  }
}
