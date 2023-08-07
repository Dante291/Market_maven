import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isfav;
  bool isinCart;

  Product(
      {this.isfav = false,
      this.isinCart = false,
      required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price});

  void ToggleFav() {
    isfav = !isfav;
    notifyListeners();
  }

  void Togglecart() {
    isinCart = !isinCart;
    notifyListeners();
  }
}
