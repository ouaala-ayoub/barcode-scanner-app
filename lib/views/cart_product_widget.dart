import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/models/core/product.dart';
import 'package:testapp/models/core/scanned_product.dart';

class CartProductWidget extends StatelessWidget {
  final ScannedProduct cartProduct;
  final Function(Product) onDeleteClicked;
  final Function(ScannedProduct) minusClicked;
  final Function(ScannedProduct) addClicked;
  final void Function(String) setQuantity;

  const CartProductWidget({
    required this.onDeleteClicked,
    required this.minusClicked,
    required this.addClicked,
    required this.setQuantity,
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
            GestureDetector(
              onTap: () {
                final key = GlobalKey<FormState>();
                final controller = TextEditingController(
                  text: cartProduct.cartQuantity.toString(),
                );
                showAdaptiveDialog(
                  context: context,
                  builder: (context) => AlertDialog.adaptive(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Entrez une quantité'),
                        Form(
                          key: key,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == '0') {
                                return 'Entez une valeur valide';
                              } else {
                                return null;
                              }
                            },
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      FilledButton(
                        onPressed: () {
                          if (key.currentState!.validate()) {
                            setQuantity(controller.text);
                            context.pop();
                          }
                        },
                        child: const Text('OK'),
                      ),
                      OutlinedButton(
                        onPressed: () => context.pop(),
                        child: const Text('Annuler'),
                      )
                    ],
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Text(
                  cartProduct.cartQuantity.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),

            // SizedBox(
            //   width: 30,
            //   child: TextField(
            //     textAlign: TextAlign.center,
            //     decoration: const InputDecoration(border: InputBorder.none),
            //     onChanged: setQuantity,
            //     keyboardType: TextInputType.number,
            //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            //     controller: controller,
            //   ),
            // ),
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
