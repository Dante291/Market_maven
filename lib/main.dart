import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Providers/products.dart';
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
        ChangeNotifierProvider(create: (context) => Cart())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop App',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(primary: Colors.purple, secondary: Colors.lime)),
        home: productOverviewScreen(),
        routes: {
          productDetailScreen.routeName: (contest) =>
              const productDetailScreen()
        },
      ),
    );
  }
}
