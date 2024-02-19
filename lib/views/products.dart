import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/main.dart';
import 'package:testapp/providers/products_list_provider.dart';
import 'package:testapp/views/product_widget.dart';
import 'package:testapp/models/core/product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({required this.provider, super.key});

  final ProductsListProvider provider;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    widget.provider.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    //todo add search
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produits"),
      ),
      body: widget.provider.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.provider.products.fold(
              (l) => Center(
                child: OutlinedButton(
                  onPressed: () => widget.provider.getAllProducts(),
                  child: const Text('Erreur, Réessayer'),
                ),
              ),
              (products) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const Padding(
                  //   padding: EdgeInsets.only(left: 20, right: 20),
                  //   child: TextField(
                  //     decoration: InputDecoration(label: Text('Rechercher')),
                  //   ),
                  // ),
                  Expanded(
                    child: products.isEmpty
                        ? const Center(
                            child: Text('Pas de produits'),
                          )
                        : ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) => ProductWidget(
                              product: products[index],
                              onClicked: (product) async {
                                final modifiedProduct =
                                    await getProductFromUser(context, product);

                                if (modifiedProduct == null) {
                                  return;
                                }

                                logger.i('modifiedProduct $modifiedProduct');

                                if (!Product.areTheSame(
                                    product, modifiedProduct)) {
                                  widget.provider.updateProduct(modifiedProduct,
                                      onSuccess: (id) {
                                    logger.i(id);
                                    widget.provider.getAllProducts();
                                  }, onFail: (e) {
                                    logger.e(e);
                                    //todo snackbar error ?
                                  });
                                }
                              },
                              onDeleteClicked: (product) async {
                                final deleted = await showAdaptiveDialog(
                                  context: context,
                                  builder: (context) => AlertDialog.adaptive(
                                    title: const Text('Supprimer ?'),
                                    content: Text(
                                        'Supprimer le produit ${product.name} de la list ?'),
                                    actions: [
                                      FilledButton(
                                        onPressed: () {
                                          widget.provider.deleteProduct(product,
                                              onSuccess: (id) {
                                            context.pop(true);
                                          }, onFail: (e) {
                                            context.pop();
                                          });
                                        },
                                        child: const Text('Oui'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () => context.pop(),
                                        child: const Text('Non'),
                                      ),
                                    ],
                                  ),
                                );
                                logger.d(deleted);
                                if (deleted == true) {
                                  widget.provider.getAllProducts();
                                } else {
                                  //todo show a error snack bar
                                }
                                return null;
                              },
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FilledButton(
                    onPressed: () async {
                      final added = await context.push('/products/add');
                      if (added == true) {
                        widget.provider.getAllProducts();
                      }
                    },
                    child: const Text('Ajouter des produits'),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
    );
  }

  Future<Product?> getProductFromUser(
      BuildContext context, Product oldProduct) async {
    final nameController = TextEditingController(text: oldProduct.name);
    final priceController =
        TextEditingController(text: oldProduct.price.toString());
    final quantityController =
        TextEditingController(text: oldProduct.quantity.toString());
    final product = showAdaptiveDialog<Product>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('Modifier les informations'),
        content: ListView(
          shrinkWrap: true,
          children: [
            Text('codebar : ${oldProduct.codebar}'),
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
                  id: oldProduct.id,
                  codebar: oldProduct.codebar,
                  price: double.parse(priceController.text),
                  name: nameController.text,
                  quantity: int.parse(quantityController.text),
                ),
              );
            },
            child: const Text('Modifier'),
          )
        ],
      ),
    );
    return product;
  }
}
