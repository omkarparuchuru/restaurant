import 'package:flutter/foundation.dart';
import '../models/order.dart';
import '../services/mock_db_service.dart';

class OrderProvider extends ChangeNotifier {
  final MockDbService db = MockDbService();

  bool storeOnline = true; // ✅ Added field

  List<Order> get all => db.orders;

  void setStoreOnline(bool value) {
    storeOnline = value;
    notifyListeners();
  }

  void acceptOrder(Order o) {
    o.status = OrderStatus.accepted;
    notifyListeners();
  }

  void markReady(Order o) {
    o.status = OrderStatus.readyToHandOver;
    notifyListeners();
  }

  void allocateBoy(Order o, dynamic boy) {
    o.status = OrderStatus.completed;
    notifyListeners();
  }

  void cancelOrder(Order o) {
    o.status = OrderStatus.cancelled;
    notifyListeners();
  }
}
