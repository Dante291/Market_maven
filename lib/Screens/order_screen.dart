import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/orders.dart';
import 'package:shop_app/Widgets/appDrawer.dart';
import 'package:shop_app/Widgets/order_item.dart';

class orderScreen extends StatefulWidget {
  static const routeName = '/order';
  const orderScreen({super.key});

  @override
  State<orderScreen> createState() => _orderScreenState();
}

class _orderScreenState extends State<orderScreen> {
  var _isloading = false;
  @override
  void initState() {
    _isloading = true;
    Provider.of<Orders>(context, listen: false)
        .fetchData()
        .then((value) => setState(() {
              _isloading = false;
            }))
        .catchError((_) {
      showDialog<Null>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        },
      );
    });
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: _isloading
          ? Center(
              child:
                  CircularProgressIndicator()) // Center the CircularProgressIndicator
          : orderData.orders.isEmpty
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
