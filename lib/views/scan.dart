import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testapp/models/core/product.dart';
import 'package:testapp/providers/products_scan_provider.dart';
import 'package:testapp/views/cart_product_widget.dart';

class ScanPage extends StatelessWidget {
  final ProductsScanProvider provider;
  const ScanPage({required this.provider, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: provider.scannedProducts.isEmpty
                ? const Center(
                    child: Text('Pas de produits'),
                  )
                : ListView.builder(
                    itemCount: provider.scannedProducts.length,
                    itemBuilder: (context, index) => CartProductWidget(
                      addClicked: (scProduct) => provider.setQuantity(
                          index, scProduct.cartQuantity + 1),
                      minusClicked: (scProduct) => scProduct.cartQuantity > 0
                          ? provider.setQuantity(
                              index, scProduct.cartQuantity - 1)
                          : null,
                      cartProduct: provider.scannedProducts[index],
                      onDeleteClicked: (product) => provider.removeProduct(
                        product.id!,
                      ),
                    ),
                  ),
          ),
          Text(
            'Total : ${provider.total} Dh',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: () async {
                  final products = await context.push('/scan_for_cart');
                  if ((products as List<Product>).isNotEmpty) {
                    provider.addProducts(products);
                  }
                  // provider.addProducts(
                  //   [
                  //     Product(
                  //         id: Random().nextInt(10),
                  //         codebar: 'codebar',
                  //         price: 100,
                  //         name: 'name',
                  //         quantity: 10),
                  //   ],
                  // );
                },
                child: const Text('Scan'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
