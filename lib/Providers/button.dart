import 'package:flutter/material.dart';
import 'Product.dart';

class button with ChangeNotifier {
  final Product ad;

  button(this.ad);

  void Togglecart() {
    ad.isinCart = false;
    print(ad);
    notifyListeners();
  }
}
