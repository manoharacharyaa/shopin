import 'package:flutter/material.dart';
import 'package:shopin/colors/colors.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });

  final String id;
  final double price;
  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              'Total: \$${(price * quantity)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Text(
              '$quantity X',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
