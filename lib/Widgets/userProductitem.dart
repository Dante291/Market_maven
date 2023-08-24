import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products.dart';
import 'package:shop_app/Screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;
  const UserProductItem(
      {super.key,
      required this.title,
      required this.imageURL,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageURL),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditproductScreen.routename, arguments: id);
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor),
          IconButton(
            onPressed: () {
              Provider.of<Products>(context, listen: false).DeleteProduct(id);
            },
            icon: Icon(Icons.delete),
            color: ColorScheme.fromSwatch().error,
          )
        ]),
      ),
    );
  }
}
