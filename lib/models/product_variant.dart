import 'package:apple_shop/models/variant.dart';
import 'package:apple_shop/models/variant_type.dart';

class ProductVariant {
  VariantType variantType;
  List<Variant> variantList;
  ProductVariant({
    required this.variantType,
    required this.variantList,
  });
}
