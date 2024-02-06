import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin/providers/products.dart';
import 'package:shopin/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    // final productsData = context.read<Products>();
    final products = productsData.items;
    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ProductItem(
          id: products[index].id,
          title: products[index].title,
          imageUrl: products[index].imageUrl,
        );
      },
    );
  }
}
