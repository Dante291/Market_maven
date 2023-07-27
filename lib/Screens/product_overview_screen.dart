import 'package:flutter/material.dart';

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
