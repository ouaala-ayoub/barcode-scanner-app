import 'package:flutter/material.dart';
import 'package:testapp/models/core/product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
    );
  }
}
