import 'package:flutter/material.dart';
import 'package:testapp/models/core/product.dart';
import 'package:testapp/providers/products_list_provider.dart';
import 'package:testapp/views/product_widget.dart';

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
                  Expanded(
                    child: products.isEmpty
                        ? const Center(
                            child: Text('Pas de produits'),
                          )
                        : ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) => ProductWidget(
                              product: products[index],
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FilledButton(
                    onPressed: () {
                      widget.provider.addProduct(
                        Product(
                            codebar: '32132123132123',
                            price: 10,
                            name: 'product x',
                            quantity: 3),
                        onSuccess: (id) {
                          widget.provider.getAllProducts();
                        },
                        onFail: (e) {
                          //todo show message
                        },
                      );
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
}
