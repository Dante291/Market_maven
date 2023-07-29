import 'package:flutter/material.dart';

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
          )
        ],
      ),
      body: ProductGrid(_showOnlyFav),
    );
  }
}
