import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Widgets/badge.dart';

import '../Widgets/product_grid.dart';

enum filterOptions {
  Favourites,
  All,
}

class productOverviewScreen extends StatefulWidget {
  @override
  State<productOverviewScreen> createState() => _productOverviewScreenState();
}

class _productOverviewScreenState extends State<productOverviewScreen> {
  var _showOnlyFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop App'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (filterOptions selectedvalue) {
              setState(() {
                if (selectedvalue == filterOptions.Favourites) {
                  _showOnlyFav = true;
                } else {
                  _showOnlyFav = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: filterOptions.Favourites,
                child: Text('Only favourites Products'),
              ),
              const PopupMenuItem(
                value: filterOptions.All,
                child: Text('All Products'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => badge(
              value: cart.itemCount.toString(),
              child: ch!,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: ProductGrid(_showOnlyFav),
    );
  }
}
