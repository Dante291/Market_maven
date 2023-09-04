import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  bool isfav;
  bool isinCart;

  Product(
      {this.isfav = false,
      this.isinCart = false,
      required this.id,
      required this.title,
      required this.imageUrl,
      required this.price});

  Future<void> ToggleFav() async {
    final oldStatus = isfav;
    isfav = !isfav;
    notifyListeners();
    Uri url = Uri.parse(
        "https://shop-app-82936-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json");
    ;
    final response = await http.patch(url,
        body: json.encode({
          'isfav': isfav,
        }));
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    if (response.statusCode != 200) {
      isfav = oldStatus;
      notifyListeners();
      throw Exception(
          'Received status code ${response.statusCode}: ${response.body}');
    }

    notifyListeners();
  }

  void Togglecart() {
    isinCart = !isinCart;
    notifyListeners();
  }
}
