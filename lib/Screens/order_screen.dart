import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/orders.dart';
import 'package:shop_app/Widgets/appDrawer.dart';
import 'package:shop_app/Widgets/order_item.dart';

class orderScreen extends StatelessWidget {
  static const routeName = '/order';
  const orderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: orderData.orders.isEmpty
          ? Center(
              child: Text(
              'No orders yet!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25, color: Theme.of(context).primaryColor),
            ))
          : ListView.builder(
              itemBuilder: (context, index) =>
                  OrderItem(orderData.orders[index]),
              itemCount: orderData.orders.length),
    );
  }
}
