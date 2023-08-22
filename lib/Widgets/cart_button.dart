import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/Product.dart';

import 'package:shop_app/Providers/cart.dart';

class cartButton extends StatefulWidget {
  @override
  _cartButtonState createState() => _cartButtonState();
}

class _cartButtonState extends State<cartButton> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final isfavourite = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    void toggle() {
      // isfavourite.Togglecart();
      cart.addItem(isfavourite.id, isfavourite.title, isfavourite.price,
          isfavourite.imageUrl);
    }

    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isfavourite.isinCart ? Colors.black54 : Colors.black54,
      ),
      child: IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            toggle();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Added to the item!',
                style: TextStyle(fontSize: 20),
              ),
              duration: Duration(seconds: 2),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  cart.removeItem(isfavourite.id);
                },
              ),
            ));
          }),
    );
  }
}
