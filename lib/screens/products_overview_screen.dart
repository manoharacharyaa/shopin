import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shopin/providers/cart.dart';
import 'package:shopin/screens/cart_screen.dart';
import 'package:shopin/widgets/app_drawer.dart';
import 'package:shopin/widgets/badge_widget.dart';
import 'package:shopin/widgets/products_grid.dart';

enum FilterOptions {
  favourites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavouyrites = false;

  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOPIN'),
        actions: [
          PopupMenuButton(
            onSelected: (selectedValue) {
              setState(() {
                logger.d(selectedValue);
                if (selectedValue == FilterOptions.favourites) {
                  _showOnlyFavouyrites = true;
                } else {
                  _showOnlyFavouyrites = false;
                }
              });
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
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => BadgeWidget(
              value: cart.itemCount.toString(),
              child: ch!,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(showFavs: _showOnlyFavouyrites),
    );
  }
}
