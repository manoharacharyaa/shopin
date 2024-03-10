import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin/providers/orders.dart' show Orders;
import 'package:shopin/widgets/app_drawer.dart';
import 'package:shopin/widgets/order_item.dart';
import 'package:shopin/widgets/progress_indicator.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YOUR ORDERS'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomProgressIndicator();
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: Text('An error occured'),
              );
            } else {
              return Consumer<Orders>(
                builder: (context, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (context, index) {
                    return OrderItem(order: orderData.orders[index]);
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
