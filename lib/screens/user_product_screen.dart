import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin/colors/colors.dart';
import 'package:shopin/providers/products.dart';
import 'package:shopin/screens/edit_product_screen.dart';
import 'package:shopin/widgets/progress_indicator.dart';
import 'package:shopin/widgets/user_product_item.dart';
import 'package:shopin/widgets/app_drawer.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});

  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = context.read<Products>();
    // final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const CustomProgressIndicator()
                : RefreshIndicator(
                    color: blue,
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                      builder: (context, productsData, _) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productsData.items.length,
                          itemBuilder: (context, index) {
                            return UserProductItem(
                              id: productsData.items[index].id,
                              title: productsData.items[index].title,
                              imageUrl: productsData.items[index].imageUrl,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
