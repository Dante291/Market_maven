import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products.dart';

class productDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const productDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProducts = Provider.of<Products>(context, listen: false)
        .items
        .firstWhere((element) => element.id == productID);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.title),
      ),
    );
  }
}
