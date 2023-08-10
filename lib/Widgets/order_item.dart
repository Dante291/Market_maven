import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Providers/orders.dart';

class OrderItem extends StatelessWidget {
  final orderItem order;
  const OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: Column(children: [
        ListTile(
          title: Text('\$${order.amount}'),
          subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime)),
          trailing: IconButton(
            icon: Icon(Icons.expand_more),
            onPressed: () {},
          ),
        )
      ]),
    );
  }
}
