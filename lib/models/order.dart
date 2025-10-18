import 'package:flutter/foundation.dart';
import 'dish.dart';
import 'delivery_boy.dart';

enum OrderStatus { placed, accepted, readyToHandOver, withDeliveryBoy, completed, cancelled }

class Order {
  final String id;
  final List<Dish> dishes;
  final DateTime createdAt;
  OrderStatus status;
  double total;
  String? customerName;
  DeliveryBoy? assignedBoy;

  Order({
    required this.id,
    required this.dishes,
    required this.createdAt,
    this.status = OrderStatus.placed,
    required this.total,
    this.customerName,
    this.assignedBoy,
  });
}
