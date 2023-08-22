import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Providers/orders.dart';
import 'package:shop_app/Widgets/cart_item.dart';

class cartScreen extends StatelessWidget {
  static const routename = '/cart';
  const cartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Cart'),
        ),
        body: Column(children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    TextButton(
                      onPressed: cart.items.isEmpty
                          ? null
                          : () {
                              {
                                Provider.of<Orders>(context, listen: false)
                                    .addOrder(cart.items.values.toList(),
                                        cart.totalAmount);
                                cart.clear();
                              }
                            },
                      child: Text(
                        'Place Order',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    )
                  ]),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          cart.items.isEmpty
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cart is empty!!',
                        style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(height: 10), // Add a spacer
                      // You can add more widgets here
                    ],
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: cart.itemCount,
                    itemBuilder: (context, i) => CartItem(
                      id: cart.items.values.toList()[i].id,
                      productID: cart.items.keys.toList()[i],
                      title: cart.items.values.toList()[i].title,
                      price: cart.items.values.toList()[i].price,
                      quant: cart.items.values.toList()[i].quant,
                      imageurl: cart.items.values.toList()[i].imageUrl,
                    ),
                  ),
                )
        ]));
  }
}
