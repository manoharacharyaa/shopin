import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin/providers/products.dart';
import 'package:shopin/widgets/user_product_item.dart';
import 'package:shopin/widgets/app_drawer.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});

  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = context.read<Products>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (context, index) {
            return UserProductItem(
              title: productsData.items[index].title,
              imageUrl: productsData.items[index].imageUrl,
            );
          },
        ),
      ),
    );
  }
}