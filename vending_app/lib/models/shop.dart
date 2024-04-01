import 'package:flutter/material.dart';
import 'package:vending_app/models/product.dart';

class Shop extends ChangeNotifier {
  final List<Product> _shop = [
    Product(
        name: "Product 1",
        price: 99.99,
        description: "item description",
        imagePath: "assets/1.png",
        buttonLink: "on-1"),
    Product(
        name: "Product 2",
        price: 99.99,
        description: "item description",
        imagePath: "assets/2.png",
        buttonLink: "on-2"),
  ];

  List<Product> _cart = [];

  List<Product> get shop => _shop;

  List<Product> get cart => _cart;

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }
}
