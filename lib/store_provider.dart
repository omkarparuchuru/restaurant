import 'package:flutter/foundation.dart';

class StoreProvider extends ChangeNotifier {
  bool _online = true;

  bool get online => _online;

  void setOnline(bool value) {
    _online = value;
    notifyListeners();
  }

  void toggleOnline() {
    _online = !_online;
    notifyListeners();
  }
}
