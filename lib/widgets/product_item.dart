import 'package:flutter/material.dart';
import 'package:shopin/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailsScreen.routeName,
          arguments: id,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            title: Text(title),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
