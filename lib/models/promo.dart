class Promo {
  String title;
  String type; // e.g., 'Percentage' or 'Flat'
  String value; // e.g., '20%' or '₹50'
  bool active;

  Promo({
    required this.title,
    required this.type,
    required this.value,
    this.active = true,
  });
}
