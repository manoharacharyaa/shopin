import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin/providers/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    //extract productId from named route
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context)
        .items
        .firstWhere((prod) => prod.id == productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Image.asset(loadedProduct.imageUrl),
    );
  }
}
