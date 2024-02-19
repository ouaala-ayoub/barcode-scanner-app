import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/models/core/product.dart';

Future<Product?> getProductFromUser(
    BuildContext context, String codeBar) async {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final product = showAdaptiveDialog<Product>(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      title: const Text('Entrer les informations'),
      content: ListView(
        shrinkWrap: true,
        children: [
          Text('codebar : $codeBar'),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              label: Text('Nom du produit'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: priceController,
            decoration: const InputDecoration(
              label: Text('Prix'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: quantityController,
            decoration: const InputDecoration(
              label: Text('Quantité'),
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => context.pop(),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: () {
            context.pop(
              Product(
                codebar: codeBar,
                price: double.parse(priceController.text),
                name: nameController.text,
                quantity: int.parse(quantityController.text),
              ),
            );
          },
          child: const Text('Ajouter'),
        )
      ],
    ),
  );
  return product;
}
