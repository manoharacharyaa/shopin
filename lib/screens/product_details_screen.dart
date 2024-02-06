import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    //extract productId from named route
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(productId),
      ),
    );
  }
}
