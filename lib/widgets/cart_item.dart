import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin/colors/colors.dart';
import 'package:shopin/providers/cart.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
  });

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: const Icon(
          Icons.delete,
          size: 40,
        ),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text(
                'Do you want to remove the item form the cart?',
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      child: SizedBox(
        height: 110,
        child: Card(
          margin: const EdgeInsets.all(10),
          color: blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
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
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
              ),
              subtitle: Text(
                'Total: \$${(price * quantity)}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              trailing: Text(
                '$quantity X',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
