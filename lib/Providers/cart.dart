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

class Cart with ChangeNotifier {}
