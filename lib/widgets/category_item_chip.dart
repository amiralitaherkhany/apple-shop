import 'package:apple_shop/models/category.dart';
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
          width: 56,
          height: 56,
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
              borderRadius: BorderRadius.circular(45),
            ),
            color: Color(categoryColor),
          ),
          child: CachedNetworkImage(
            imageUrl: category.icon!,
            placeholder: (context, url) => Container(
              color: Colors.grey,
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.red[500],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          category.title!,
          style: const TextStyle(
            fontFamily: 'SB',
            color: Colors.black,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
