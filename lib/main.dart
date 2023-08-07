import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Providers/orders.dart';
import 'package:shop_app/Providers/products.dart';
import 'package:shop_app/Screens/cart_screen.dart';
import 'package:shop_app/Screens/product_detail_screen.dart';
import 'package:shop_app/Screens/product_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop App',
        theme: ThemeData(primarySwatch: Colors.brown),
        home: productOverviewScreen(),
        routes: {
          productDetailScreen.routeName: (contest) =>
              const productDetailScreen(),
          cartScreen.routename: (context) => cartScreen()
        },
      ),
    );
  }
}
