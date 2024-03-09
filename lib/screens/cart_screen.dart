import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin/colors/colors.dart';
import 'package:shopin/providers/cart.dart' show Cart;
import 'package:shopin/providers/orders.dart';
import 'package:shopin/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    // final cart = context.watch<Cart>();
    final cart = Provider.of<Cart>(context);
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
                borderRadius: BorderRadius.circular(15),
              ),
              color: blue,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Total',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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
                    OrderButton(cart: cart),
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
                  productId: cart.items.keys.toList()[index],
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: _isLoading
          ? Container(
              height: 30,
              width: 50,
              padding: const EdgeInsets.only(left: 20),
              child: const CircularProgressIndicator(
                color: white,
              ),
            )
          : ElevatedButton(
              onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await Provider.of<Orders>(context, listen: false)
                          .addOrder(
                        widget.cart.items.values.toList(),
                        widget.cart.totalAmount,
                      );
                      setState(() {
                        _isLoading = false;
                      });
                      widget.cart.clear();
                    },
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: const MaterialStatePropertyAll(white),
              ),
              child: Text(
                'ORDER',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
              ),
            ),
    );
  }
}
