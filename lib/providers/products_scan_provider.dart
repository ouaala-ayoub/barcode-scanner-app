import 'package:flutter/material.dart';
import 'package:testapp/models/core/product.dart';
import 'package:testapp/models/core/scanned_product.dart';

class ProductsScanProvider extends ChangeNotifier {
  final scannedProducts = <ScannedProduct>[];
  double get total => scannedProducts.fold(
        0,
        (previousValue, element) =>
            previousValue + element.product.price * element.cartQuantity,
      );

  addProducts(List<Product> products) {
    final productsToAdd = products
        .where((element) => !scannedProducts
            .any((scanned) => scanned.product.codebar == element.codebar))
        .map((product) => ScannedProduct(product: product));
    scannedProducts.addAll(productsToAdd);
    notifyListeners();
  }

  removeProduct(int id) {
    scannedProducts.removeWhere((element) => element.product.id == id);
    notifyListeners();
  }

  setQuantity(int index, int quantity) {
    scannedProducts[index].cartQuantity = quantity;
    notifyListeners();
  }
}
