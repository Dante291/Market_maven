import 'dart:convert';

import 'package:flutter/material.dart';
import './Product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isfav).toList();
  }

  Future<void> addProduct(Product product) async {
    Uri url = Uri.parse(
        "https://shop-app-82936-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");
    ;
    try {
      final value = await http.post(url,
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'imageURL': product.imageUrl,
            'isfav': product.isfav
          }));

      var newProduct = Product(
          id: json.decode(value.body)['name'],
          title: product.title,
          imageUrl: product.imageUrl,
          price: product.price);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    Uri url = Uri.parse(
        "https://shop-app-82936-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json");
    ;
    await http.patch(url,
        body: json.encode({
          'title': newProduct.title,
          'imageURL': newProduct.imageUrl,
          'price': newProduct.price,
        }));
    _items[prodIndex] = newProduct;
    notifyListeners();
  }

  void DeleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> fetchData() async {
    Uri url = Uri.parse(
        "https://shop-app-82936-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");
    ;
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodID, prodData) {
        loadedProducts.add(Product(
            id: prodID,
            title: prodData['title'],
            imageUrl: prodData['imageURL'],
            price: prodData['price']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
