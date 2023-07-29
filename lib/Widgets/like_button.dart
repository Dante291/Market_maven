import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Models/Product.dart';

class LikeButton extends StatefulWidget {
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bool _isLiked=false;
    final isfavourite = Provider.of<Product>(context);
    void _toggleLike() {
      setState(() {
        isfavourite.ToggleFav();
      });

      isfavourite.isfav
          ? animationController.forward()
          : animationController.reverse();
    }

    return GestureDetector(
      onTap: () {
        isfavourite.ToggleFav();
      },
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isfavourite.isfav ? Colors.black54 : Colors.black54,
            ),
            child: Icon(
              Icons.favorite,
              color: isfavourite.isfav ? Colors.red : Colors.white,
              size: 30 * scaleAnimation.value,
            ),
          );
        },
      ),
    );
  }
}
