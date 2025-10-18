import '../models/order.dart';
import '../models/dish.dart';
import '../models/delivery_boy.dart';
import 'mock_db_service.dart';

class OrderService {
  final MockDbService db;
  OrderService(this.db);

  List<Order> getAllOrders() => db.orders;

  Order createOrder(List<Dish> items, {String? customerName}) {
    final id = db.createOrderId();
    final total = items.fold<double>(0, (s, d) => s + d.price);
    final o = Order(id: id, dishes: items, createdAt: DateTime.now(), total: total, customerName: customerName);
    db.orders.insert(0, o);
    return o;
  }

  void updateStatus(Order order, OrderStatus status) {
    order.status = status;
  }

  bool allocateDeliveryBoy(Order order, DeliveryBoy boy) {
    if (!boy.available) return false;
    order.assignedBoy = boy;
    boy.available = false;
    order.status = OrderStatus.withDeliveryBoy;
    return true;
  }
}
