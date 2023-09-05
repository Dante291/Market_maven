import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:http/http.dart' as http;

class orderItem {
  final String id;
  final double amount;
  final List<cartItem> products;
  final DateTime dateTime;

  orderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<orderItem> _orders = [];

  List<orderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<cartItem> cartPRoduct, double total) async {
    Uri url = Uri.parse(
        "https://shop-app-82936-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json");
    ;
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartPRoduct
              .map((e) => {
                    'id': e.id,
                    'price': e.price,
                    'imageUrl': e.imageUrl,
                    'quantity': e.quant,
                    'title': e.title
                  })
              .toList(),
        }));
    _orders.insert(
      0,
      orderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartPRoduct,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> fetchData() async {
    Uri url = Uri.parse(
        "https://shop-app-82936-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json");
    ;

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<orderItem> loadedOrders = [];
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderID, orderData) {
      loadedOrders.add(orderItem(
          id: orderID,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((e) => cartItem(
                  imageUrl: e['imageUrl'],
                  id: e['id'],
                  title: e['title'],
                  quant: e['quantity'],
                  price: e['price']))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime'])));
    });
    _orders = loadedOrders;
    notifyListeners();
  }
}
