import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/Product.dart';
import 'package:shop_app/Screens/product_detail_screen.dart';
import 'cart_button.dart';
import 'package:shop_app/Widgets/like_button.dart';

class productItem extends StatefulWidget {
  @override
  State<productItem> createState() => _productItemState();
}

class _productItemState extends State<productItem> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return Stack(children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(productDetailScreen.routeName,
                arguments: product.id);
          },
          child: GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(
                product.title,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      Positioned(top: 6, right: 6, child: LikeButton()),
      Positioned(top: 55, right: 6, child: cartButton())
    ]);
  }
}
