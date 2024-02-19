import 'package:flutter/material.dart';
import 'package:testapp/models/core/product.dart';
import 'package:testapp/models/core/scanned_product.dart';

class CartProductWidget extends StatelessWidget {
  final ScannedProduct cartProduct;
  final Function(Product) onDeleteClicked;
  final Function(ScannedProduct) minusClicked;
  final Function(ScannedProduct) addClicked;

  const CartProductWidget({
    required this.onDeleteClicked,
    required this.minusClicked,
    required this.addClicked,
    required this.cartProduct,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final product = cartProduct.product;
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
            GestureDetector(
              onTap: () => minusClicked(cartProduct),
              child: const Icon(Icons.remove_circle_outlined),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text(
                cartProduct.cartQuantity.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            GestureDetector(
              onTap: () => addClicked(cartProduct),
              child: const Icon(Icons.add_circle_outlined),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () async => onDeleteClicked(product),
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
