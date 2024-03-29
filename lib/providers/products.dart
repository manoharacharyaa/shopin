// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopin/models/http_exception.dart';
import 'package:shopin/providers/product.dart';
import 'package:http/http.dart' as http;

class Products extends ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'iPhone 15 ProMax',
    //   description:
    //       'The most powerful Phone in the world, powered by Apples A17 Pro chip which suports ray tracing, with pro-motion Retina display, Grade 5 Titanium ',
    //   price: 1150,
    //   imageUrl: 'https://shorturl.at/bqwL4',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Samsung S24 Ultra',
    //   description:
    //       'The best Android phone in th world, powered by Snapdragon 8 Gen 3 chip for galaxy with the best display in the world, its made with Grade 2 Titanium',
    //   price: 1000,
    //   imageUrl: 'https://shorturl.at/jrxAX',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Pixel 8 Pro',
    //   description:
    //       'The best Camera phone in the world, powered by Tensor G3 chip, it houses a lot of AI features, it has Clean Stock Android',
    //   price: 800,
    //   imageUrl: 'https://shorturl.at/bfhlp',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'OnePlus 12',
    //   description:
    //       'The value for money smartphone in the world, powered by Snapdragon 8 Gen 3 chip, it provides best overall package with good display, camera & performance',
    //   price: 700,
    //   imageUrl: 'https://rb.gy/rdte09',
    // ),
  ];

  // var _showFavouritsOnly = false;

  final String? authToken;
  final String? userId;
  Products(this.authToken, this._items, this.userId);

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

  Future<void> fetchAndSetProduct() async {
    var url =
        'https://shopin-379ad-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData.isEmpty) {
        return;
      }
      uri = Uri.parse(
          'https://shopin-379ad-default-rtdb.firebaseio.com/userFavorites/$userId/$userId.json?auth=$authToken');
      final favouriteResponse = await http.get(uri);
      final favouriteData = json.decode(favouriteResponse.body);
      final List<Product> loadesProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadesProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavourite:
                favouriteData == null ? false : favouriteData[prodId] ?? false,
          ),
        );
      });
      _items = loadesProducts;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://shopin-379ad-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    Uri uri = Uri.parse(url);
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://shopin-379ad-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
      Uri uri = Uri.parse(url);
      await http.patch(
        uri,
        body: jsonEncode({
          'title': newProduct.title,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price,
        }),
      );
      _items[prodIndex] = newProduct;
    } else {
      print('...');
    }
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://shopin-379ad-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    Uri uri = Uri.parse(url);
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(uri);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException(message: 'Could not delete product');
    }
    existingProduct = null;
  }
}
