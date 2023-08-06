import 'package:flutter/material.dart';

class cartItem {
  final String id;
  final String title;
  final int quant;
  final double price;

  cartItem({
    required this.id,
    required this.title,
    required this.quant,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  late Map<String, cartItem> _items = {};

  Map<String, cartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(
    String productId,
    String title,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => cartItem(
              id: value.id,
              title: value.title,
              quant: value.quant + 1,
              price: value.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => cartItem(
              id: DateTime.now().toString(),
              title: title,
              quant: 1,
              price: price));
    }
    notifyListeners();
  }
}
