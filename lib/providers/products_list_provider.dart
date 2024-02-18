import 'package:flutter/material.dart';
import 'package:testapp/models/core/product.dart';
import 'package:dartz/dartz.dart';
import 'package:testapp/models/helpers/db_helpers.dart';

class ProductsListProvider extends ChangeNotifier {
  ProductsListProvider({required this.helper});

  bool loading = true;
  final ProductsHelper helper;

  Either<dynamic, List<Product>> products = const Right([]);
  getAllProducts() async {
    loading = true;
    products = await helper.getAllProducts();
    loading = false;
    notifyListeners();
  }

  addProduct(Product product,
      {required Function(int) onSuccess,
      required Function(dynamic) onFail}) async {
    helper.addProduct(product).then(
          (value) => value.fold(
            (e) => onFail(e),
            (id) => onSuccess(id),
          ),
        );
  }
}
