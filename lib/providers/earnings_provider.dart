import 'package:flutter/material.dart';
import '../services/mock_db_service.dart';
import '../models/order.dart';
import 'package:intl/intl.dart';

class EarningsProvider extends ChangeNotifier {
  final MockDbService db = MockDbService();

  double getDayIncome(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return db.orders.where((o) => o.createdAt.isAfter(start) && o.createdAt.isBefore(end) && o.status == OrderStatus.completed)
        .fold(0.0, (s, o) => s + o.total);
  }

  int getDayOrders(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return db.orders.where((o) => o.createdAt.isAfter(start) && o.createdAt.isBefore(end) && o.status == OrderStatus.completed).length;
  }

// week/month similar helpers can be added
}
