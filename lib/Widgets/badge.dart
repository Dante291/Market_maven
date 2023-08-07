import 'package:flutter/material.dart';
import '../Screens/cart_screen.dart';

class badge extends StatelessWidget {
  const badge({
    required this.child,
    required this.value,
  });

  final Widget child;
  final String value;
  final Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 10,
          top: 8,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(cartScreen.routename),
            child: Container(
              padding: EdgeInsets.all(2.0),
              // color: Theme.of(context).accentColor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: color,
              ),
              constraints: BoxConstraints(
                minWidth: 2,
                minHeight: 2,
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
