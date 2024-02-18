import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                              onClicked: (product) {},
                              onDeleteClicked: (product) {},
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FilledButton(
                    onPressed: () async {
                      // widget.provider.addProduct(
                      //   Product(
                      //       codebar: '32132123132123',
                      //       price: 10,
                      //       name: 'product x',
                      //       quantity: 3),
                      //   onSuccess: (id) {
                      //     widget.provider.getAllProducts();
                      //   },
                      //   onFail: (e) {
                      //     //todo show message
                      //   },
                      // );
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
}
