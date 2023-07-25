import 'package:flutter/material.dart';
import 'package:shop_app/Widgets/like_button.dart';

class productItem extends StatefulWidget {
  final String id;
  final String productTitle;
  final String imageUrl;

  const productItem(
      {super.key,
      required this.id,
      required this.productTitle,
      required this.imageUrl});

  @override
  State<productItem> createState() => _productItemState();
}

class _productItemState extends State<productItem> {
  bool _isLiked = false;

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              widget.productTitle,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned(top: 6, right: 6, child: LikeButton()),
    ]);
  }
}
