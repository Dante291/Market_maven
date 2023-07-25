import 'package:flutter/material.dart';

class productDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const productDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prductId = ModalRoute.of(context)?.settings.arguments as String;
    return const Placeholder();
  }
}
