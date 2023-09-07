import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/auth.dart';

import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Providers/orders.dart';
import 'package:shop_app/Providers/products.dart';
import 'package:shop_app/Screens/auth_screen.dart';
import 'package:shop_app/Screens/cart_screen.dart';
import 'package:shop_app/Screens/edit_product_screen.dart';
import 'package:shop_app/Screens/order_screen.dart';
import 'package:shop_app/Screens/product_detail_screen.dart';
import 'package:shop_app/Screens/product_overview_screen.dart';
import 'package:shop_app/Screens/user_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => auth()),
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child: Consumer<auth>(
        builder: (context, value, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Shop App',
          theme: ThemeData(primarySwatch: Colors.brown),
          home: value.isAuthenticated ? productOverviewScreen() : AuthScreen(),
          routes: {
            productDetailScreen.routeName: (contest) =>
                const productDetailScreen(),
            cartScreen.routename: (context) => cartScreen(),
            orderScreen.routeName: (context) => orderScreen(),
            UserProductScreen.routename: (context) => UserProductScreen(),
            EditproductScreen.routename: (context) => EditproductScreen(),
          },
        ),
      ),
    );
  }
}
