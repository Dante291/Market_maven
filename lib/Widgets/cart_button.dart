import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/Product.dart';

import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Providers/products.dart';

class cartButton extends StatefulWidget {
  @override
  _cartButtonState createState() => _cartButtonState();
}

class _cartButtonState extends State<cartButton> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final m = Provider.of<Products>(context);
    final isfavourite = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    void toggle() {
      isfavourite.Togglecart();
      isfavourite.isinCart
          ? cart.addItem(isfavourite.id, isfavourite.title, isfavourite.price,
              isfavourite.imageUrl)
          : cart.removeItem(isfavourite.id);
    }

    return GestureDetector(
        onTap: toggle,
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isfavourite.isinCart ? Colors.black54 : Colors.black54,
          ),
          child: Icon(
            Icons.shopping_cart,
            color: isfavourite.isinCart ? Colors.blue : Colors.white,
            size: 25,
          ),
        ));
  }
}