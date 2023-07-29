import 'package:flutter/material.dart';
import 'package:shop_app/Providers/products.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showfavs;

  ProductGrid(this.showfavs);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products =
        showfavs == true ? productData.favouriteItems : productData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(13),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: productItem(),
            ));
  }
}
