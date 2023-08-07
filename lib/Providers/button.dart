import 'package:flutter/material.dart';
import 'Product.dart';

class button with ChangeNotifier {
  bool isinCarT = false;

  void Togglecart(bool x) {
    x = isinCarT;
    notifyListeners();
  }
}
