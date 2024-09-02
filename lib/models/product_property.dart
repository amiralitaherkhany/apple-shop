class Property {
  String title;
  String value;
  Property({
    required this.title,
    required this.value,
  });

  factory Property.fromMapJson(Map<String, dynamic> map) {
    return Property(
      title: map['title'] ?? '',
      value: map['value'] ?? '',
    );
  }
}
