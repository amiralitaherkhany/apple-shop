import 'package:apple_shop/bloc/categoryProduct/bloc/category_product_bloc.dart';
import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/ui/screens/product_list_screen.dart';
import 'package:apple_shop/util/extensions/string_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItemChip extends StatelessWidget {
  const CategoryItemChip({
    super.key,
    required this.category,
  });
  final Category category;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CategoryProductBloc()
              ..add(CategoryProductRequestData(categoryId: category.id!)),
            child: ProductListScreen(category: category),
          ),
        ));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.r),
            width: 56.w,
            height: 56.h,
            decoration: ShapeDecoration(
              shadows: [
                BoxShadow(
                  color: category.color.parseToColor().withOpacity(0.0368),
                  offset: const Offset(0, 2.77),
                  blurRadius: 2.21,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: category.color.parseToColor().withOpacity(0.0445),
                  offset: const Offset(0, 6.65),
                  blurRadius: 5.32,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: category.color.parseToColor().withOpacity(0.0482),
                  offset: const Offset(0, 12.52),
                  blurRadius: 10.02,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: category.color.parseToColor().withOpacity(0.051),
                  offset: const Offset(0, 22.34),
                  blurRadius: 17.87,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: category.color.parseToColor().withOpacity(0.0549),
                  offset: const Offset(0, 41.78),
                  blurRadius: 33.42,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: category.color.parseToColor().withOpacity(0.07),
                  offset: const Offset(0, 100),
                  blurRadius: 80,
                  spreadRadius: 0,
                ),
              ],
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(45.r),
              ),
              color: category.color.parseToColor(),
            ),
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: category.icon!,
              placeholder: (context, url) => Container(
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(45.r),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: ShapeDecoration(
                  color: Colors.red,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(45.r),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            category.title!,
            style: TextStyle(
              fontFamily: 'SB',
              color: Colors.black,
              fontSize: 12.sp,
            ),
          )
        ],
      ),
    );
  }
}
