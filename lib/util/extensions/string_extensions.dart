import 'package:flutter/material.dart';

extension ParseToColor on String? {
  Color parseToColor() {
    int color = int.parse('FF$this', radix: 16);
    return Color(color);
  }
}
