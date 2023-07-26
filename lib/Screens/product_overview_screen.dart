import 'package:flutter/material.dart';
import 'package:shop_app/Models/Product.dart';
import 'package:shop_app/Widgets/product_item.dart';
import '../Widgets/product_grid.dart';

class productOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop App'),
      ),
      body: ProductGrid(),
    );
  }
}
