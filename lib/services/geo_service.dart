import 'dart:async';
import '../models/delivery_boy.dart';
import 'mock_db_service.dart';
import 'dart:math';

class GeoService {
  final MockDbService db;
  final Random _rng = Random();
  final Map<String, StreamController<DeliveryBoy>> _controllers = {};

  GeoService(this.db);

  Stream<DeliveryBoy> locationStream(DeliveryBoy boy) {
    if (_controllers.containsKey(boy.id)) {
      return _controllers[boy.id]!.stream;
    } else {
      final controller = StreamController<DeliveryBoy>.broadcast();
      _controllers[boy.id] = controller;
      // emit fake updates
      Timer.periodic(const Duration(seconds: 3), (t) {
        boy.lat = 12.97 + _rng.nextDouble() / 100; // near Bangalore as example
        boy.lng = 77.59 + _rng.nextDouble() / 100;
        controller.add(boy);
      });
      return controller.stream;
    }
  }
}
