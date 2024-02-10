import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shopin/providers/products.dart';
import 'package:shopin/widgets/products_grid.dart';

enum FilterOptions {
  favourites,
  all,
}

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context, listen: false);
    final logger = Logger();
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOPIN'),
        actions: [
          PopupMenuButton(
            onSelected: (selectedValue) {
              logger.d(selectedValue);
              if (selectedValue == FilterOptions.favourites) {
                productsContainer.showFavouritsOnly();
              } else {
                productsContainer.showAll();
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favourites,
                child: Text('Only Favourite'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show All'),
              ),
            ],
          )
        ],
      ),
      body: const ProductsGrid(),
    );
  }
}
