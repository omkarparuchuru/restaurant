import 'package:uuid/uuid.dart';
import '../models/order.dart';
import '../models/dish.dart';
import '../models/delivery_boy.dart';
import '../models/promotion.dart';

class MockDbService {
  final _uuid = const Uuid();

  final List<Order> orders = [];
  final List<Dish> dishes = [];
  final List<DeliveryBoy> boys = [];
  final List<Promotion> promos = [];

  MockDbService() {
    // seed some dishes, boys and promos
    dishes.addAll([
      Dish(id: _uuid.v4(), name: 'Paneer Butter Masala', price: 249, recommended: true),
      Dish(id: _uuid.v4(), name: 'Veg Biryani', price: 149),
      Dish(id: _uuid.v4(), name: 'Gulab Jamun', price: 89),
    ]);

    boys.addAll([
      DeliveryBoy(id: _uuid.v4(), name: 'Raju', phone: '9999999999'),
      DeliveryBoy(id: _uuid.v4(), name: 'Ajay', phone: '8888888888'),
    ]);

    promos.addAll([
      Promotion(id: _uuid.v4(), title: 'Flat 20% Off', type: 'percentage', value: 20),
      Promotion(id: _uuid.v4(), title: '149/- off on 300/-', type: 'flat', value: 149),
    ]);

    // seed some orders
    orders.addAll([
      Order(id: _uuid.v4(), dishes: [dishes[0]], createdAt: DateTime.now().subtract(const Duration(hours:2)), total: 249),
      Order(id: _uuid.v4(), dishes: [dishes[1], dishes[2]], createdAt: DateTime.now().subtract(const Duration(hours:1)), total: 238, status: OrderStatus.readyToHandOver),
    ]);
  }

  String createOrderId() => _uuid.v4();
}
