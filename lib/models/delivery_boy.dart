class DeliveryBoy {
  String id;
  String name;
  String phone;
  double? lat;
  double? lng;
  bool available;

  DeliveryBoy({
    required this.id,
    required this.name,
    required this.phone,
    this.lat,
    this.lng,
    this.available = true,
  });
}
