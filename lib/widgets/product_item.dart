import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shopin/providers/product.dart';
import 'package:shopin/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
//  final product = context.watch<Product>();
    final logger = Logger();

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailsScreen.routeName,
          arguments: product.id,
        );
        logger.d(product.id);
        print(product.title);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            leading: IconButton(
              onPressed: () {
                product.toggleFavouriteStatus();
              },
              icon: product.isFavourite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
            ),
            title: Text(product.title),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          child: Image.asset(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
