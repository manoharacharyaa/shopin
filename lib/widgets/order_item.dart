import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopin/providers/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});

  final ord.OrderItem order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(order.dateTime),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.expand_more),
            ),
          ),
        ],
      ),
    );
  }
}