import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products.dart';
import 'package:shop_app/Screens/edit_product_screen.dart';
import 'package:shop_app/Widgets/appDrawer.dart';
import 'package:shop_app/Widgets/userProductitem.dart';

class UserProductScreen extends StatelessWidget {
  static const routename = '/user-product';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final prodctData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditproductScreen.routename);
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: prodctData.items.length,
              itemBuilder: (context, index) => Column(
                    children: [
                      UserProductItem(
                        id: prodctData.items[index].id,
                        title: prodctData.items[index].title,
                        imageURL: prodctData.items[index].imageUrl,
                      ),
                      Divider()
                    ],
                  )),
        ),
      ),
    );
  }
}
