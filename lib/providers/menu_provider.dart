import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/dish.dart';
import '../services/mock_db_service.dart';

class MenuProvider extends ChangeNotifier {
  final MockDbService db = MockDbService();
  final _uuid = const Uuid();

  List<Dish> get dishes => db.dishes;

  void addDish(String name, double price, String desc) {
    db.dishes.add(
      Dish(
        id: _uuid.v4(),
        name: name,
        price: price,
        description: desc,
      ),
    );
    notifyListeners();
  }

  void updateDish(String id, String name, double price, String desc) {
    final idx = db.dishes.indexWhere((d) => d.id == id);
    if (idx != -1) {
      db.dishes[idx] = Dish(
        id: id,
        name: name,
        price: price,
        description: desc,
        imageUrl: db.dishes[idx].imageUrl,
        recommended: db.dishes[idx].recommended,
      );
      notifyListeners();
    }
  }

  void removeDish(String id) {
    db.dishes.removeWhere((d) => d.id == id);
    notifyListeners();
  }

  void toggleRecommend(String id) {
    final dish = db.dishes.firstWhere(
          (x) => x.id == id,
      orElse: () => throw Exception('Dish not found'),
    );
    dish.recommended = !dish.recommended;
    notifyListeners();
  }
}
