import 'package:flutter/material.dart';
import 'package:testapp/models/core/product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  final Function(Product) onClicked;
  final Function(Product) onDeleteClicked;
  const ProductWidget(
      {required this.onClicked,
      required this.onDeleteClicked,
      required this.product,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(
        '${product.price} Dh',
        style: const TextStyle(fontSize: 16),
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'x${product.quantity}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: onDeleteClicked(product),
              child: const Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: 32,
              ),
            )
          ],
        )
      ]),
    );
  }
}
