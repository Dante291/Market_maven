import 'package:flutter/material.dart';

class cartItem {
  final String id;
  final String title;
  final int quant;
  final double price;
  final String imageUrl;

  cartItem({
    required this.imageUrl,
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

  double get totalAmount {
    var total = 0.00;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quant;
    });
    return total;
  }

  void addItem(String productId, String title, double price, String imageURL) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => cartItem(
              id: value.id,
              title: value.title,
              quant: value.quant + 1,
              price: value.price,
              imageUrl: value.imageUrl));
    } else {
      _items.putIfAbsent(
          productId,
          () => cartItem(
                id: DateTime.now().toString(),
                title: title,
                quant: 1,
                price: price,
                imageUrl: imageURL,
              ));
    }
    notifyListeners();
  }
}
