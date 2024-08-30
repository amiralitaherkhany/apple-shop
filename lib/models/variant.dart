class Variant {
  String id;
  String name;
  String typeId;
  String value;
  int priceChange;
  Variant({
    required this.id,
    required this.name,
    required this.typeId,
    required this.value,
    required this.priceChange,
  });

  factory Variant.fromMapJson(Map<String, dynamic> map) {
    return Variant(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      typeId: map['type_id'] ?? '',
      value: map['value'] ?? '',
      priceChange: map['price_change']?.toInt() ?? 0,
    );
  }
}
