import 'package:intl/intl.dart';

extension PriceFormatter on int {
  String get formatPrice {
    // Use NumberFormat from intl package for formatting
    final formatter = NumberFormat('#,###.##');
    return formatter.format(this);
  }
}
