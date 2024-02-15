import 'package:flutter/material.dart';
import 'package:shopin/providers/product.dart';

class Products extends ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'iPhone 15 ProMax',
      description:
          'The most powerful Phone in the world, powered by Apples A17 Pro chip which suports ray tracing, with pro-motion Retina display, Grade 5 Titanium ',
      price: 1150,
      imageUrl: 'https://shorturl.at/bqwL4',
    ),
    Product(
      id: 'p2',
      title: 'Samsung S24 Ultra',
      description:
          'The best Android phone in th world, powered by Snapdragon 8 Gen 3 chip for galaxy with the best display in the world, its made with Grade 2 Titanium',
      price: 1000,
      imageUrl: 'https://shorturl.at/jrxAX',
    ),
    Product(
      id: 'p3',
      title: 'Pixel 8 Pro',
      description:
          'The best Camera phone in the world, powered by Tensor G3 chip, it houses a lot of AI features, it has Clean Stock Android',
      price: 800,
      imageUrl: 'https://shorturl.at/bfhlp',
    ),
    Product(
      id: 'p4',
      title: 'OnePlus 12',
      description:
          'The value for money smartphone in the world, powered by Snapdragon 8 Gen 3 chip, it provides best overall package with good display, camera & performance',
      price: 700,
      imageUrl: 'https://rb.gy/rdte09',
    ),
  ];

  // var _showFavouritsOnly = false;

  List<Product> get items {
    // if (_showFavouritsOnly) {
    //   return _items.where((prodItem) => prodItem.isFavourite).toList();
    // }
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((prodItems) => prodItems.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavouritsOnly() {
  //   _showFavouritsOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavouritsOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
    } else {
      print('...');
    }
    notifyListeners();
  }
}
