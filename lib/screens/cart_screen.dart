import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin/colors/colors.dart';
import 'package:shopin/providers/cart.dart' show Cart;
import 'package:shopin/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = context.read<Cart>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY CART'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 110,
            child: Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: blue,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide.none,
                      backgroundColor: transparentBlue,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'ORDER NOW',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                return CartItem(
                  id: cart.items.values.toList()[index].id,
                  title: cart.items.values.toList()[index].title,
                  quantity: cart.items.values.toList()[index].quantity,
                  price: cart.items.values.toList()[index].price,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
