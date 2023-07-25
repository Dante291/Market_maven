import 'package:flutter/material.dart';

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
      GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            widget.productTitle,
            textAlign: TextAlign.center,
          ),
        ),
        child: Image.network(
          widget.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
          top: 6,
          right: 6,
          child: GestureDetector(
            onTap: _toggleLike,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isLiked ? Colors.red : Colors.black54,
              ),
              child: Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
                size: 30,
              ),
            ),
          )),
    ]);
  }
}
