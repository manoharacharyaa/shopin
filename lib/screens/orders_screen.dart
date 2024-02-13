import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin/providers/orders.dart' show Orders;
import 'package:shopin/widgets/app_drawer.dart';
import 'package:shopin/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = context.read<Orders>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('YOUR ORDERS'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) {
          return OrderItem(order: orderData.orders[index]);
        },
      ),
    );
  }
}
