import 'package:flutter/material.dart';
import 'package:shopin/colors/colors.dart';
import 'package:shopin/screens/orders_screen.dart';
import 'package:shopin/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: grey,
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: Text(
              'Shop',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text(
              'Orders',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, OrdersScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_calendar_outlined),
            title: Text(
              'Manage Product',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                UserProductScreen.routeName,
              );
            },
          ),
        ],
      ),
    );
  }
}
