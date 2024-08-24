import 'package:flutter/material.dart';

class CategoryItemChip extends StatelessWidget {
  const CategoryItemChip(
      {super.key, required this.index, required this.isListed});
  final int index;
  final bool isListed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isListed == true
          ? EdgeInsets.only(left: 20, right: index == 0 ? 44 : 0)
          : const EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: ShapeDecoration(
              shadows: [
                BoxShadow(
                  color: const Color(0xFFFBAD40).withOpacity(0.0368),
                  offset: const Offset(0, 2.77),
                  blurRadius: 2.21,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0xFFFBAD40).withOpacity(0.0445),
                  offset: const Offset(0, 6.65),
                  blurRadius: 5.32,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0xFFFBAD40).withOpacity(0.0482),
                  offset: const Offset(0, 12.52),
                  blurRadius: 10.02,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0xFFFBAD40).withOpacity(0.051),
                  offset: const Offset(0, 22.34),
                  blurRadius: 17.87,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0xFFFBAD40).withOpacity(0.0549),
                  offset: const Offset(0, 41.78),
                  blurRadius: 33.42,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0xFFFBAD40).withOpacity(0.07),
                  offset: const Offset(0, 100),
                  blurRadius: 80,
                  spreadRadius: 0,
                ),
              ],
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
              color: const Color.fromRGBO(251, 173, 64, 1),
            ),
            child: const Icon(
              Icons.ads_click,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'همه',
            style: TextStyle(
              fontFamily: 'SB',
              color: Colors.black,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
