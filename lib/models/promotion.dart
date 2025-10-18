class Promotion {
  String id;
  String title;
  String description;
  String type; // percentage / flat / coupon
  double value;
  bool active;

  Promotion({
    required this.id,
    required this.title,
    this.description = '',
    required this.type,
    required this.value,
    this.active = true,
  });
}
