import 'package:flutter/material.dart';
import 'package:shop_app/Screens/order_screen.dart';
import 'package:shop_app/Screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text('Shop'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Home'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        Divider(),
        ListTile(
            leading: Icon(Icons.payment),
            title: Text('Checkout'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(orderScreen.routeName);
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.edit),
            title: Text('My Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routename);
            })
      ]),
    );
  }
}
