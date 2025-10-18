class Dish {
  String id;
  String name;
  String description;
  double price;
  bool recommended;
  String imageUrl;

  Dish({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    this.recommended = false,
    this.imageUrl = '',
  });
}
