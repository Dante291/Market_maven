import 'package:flutter/material.dart';
import 'package:shop_app/Providers/cart.dart';

import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productID;
  final String title;
  final double price;
  final int quant;
  final String imageurl;

  const CartItem({
    super.key,
    required this.id,
    required this.productID,
    required this.title,
    required this.price,
    required this.quant,
    required this.imageurl,
  });

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productID);
      },
      child: Card(
        elevation: 8,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: FittedBox(
                child: Image.network(
                  imageurl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text(
              'Price: \$${price * quant}',
              style: TextStyle(fontSize: 15),
            ),
            trailing: Text('$quant x', style: TextStyle(fontSize: 17)),
          ),
        ),
      ),
    );
  }
}
