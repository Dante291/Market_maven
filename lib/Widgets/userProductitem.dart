import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageURL;
  const UserProductItem(
      {super.key, required this.title, required this.imageURL});

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
              onPressed: () {},
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
            color: ColorScheme.fromSwatch().error,
          )
        ]),
      ),
    );
  }
}
