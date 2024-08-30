class VariantType {
  String id;
  String name;
  String title;
  VariantTypeEnum type;
  VariantType({
    required this.id,
    required this.name,
    required this.title,
    required this.type,
  });

  factory VariantType.fromMapJson(Map<String, dynamic> map) {
    return VariantType(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      title: map['title'] ?? '',
      type: _getTypeEnum(map['type']),
    );
  }
}

VariantTypeEnum _getTypeEnum(String type) {
  switch (type) {
    case 'Color':
      return VariantTypeEnum.Color;
    case 'Storage':
      return VariantTypeEnum.Storage;
    case 'Voltage':
      return VariantTypeEnum.Voltage;
    default:
      return VariantTypeEnum.Color;
  }
}

enum VariantTypeEnum { Color, Storage, Voltage }
