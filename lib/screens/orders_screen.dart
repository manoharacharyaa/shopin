import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin/providers/orders.dart' show Orders;
import 'package:shopin/widgets/app_drawer.dart';
import 'package:shopin/widgets/order_item.dart';
import 'package:shopin/widgets/progress_indicator.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = context.read<Orders>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('YOUR ORDERS'),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const CustomProgressIndicator()
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (context, index) {
                return OrderItem(order: orderData.orders[index]);
              },
            ),
    );
  }
}
