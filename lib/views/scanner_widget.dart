import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:testapp/main.dart';
import 'package:testapp/models/core/product.dart';
import 'package:testapp/models/helpers/functions_helper.dart';
import 'package:testapp/providers/products_list_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class ScannerWidget extends StatelessWidget {
  final ProductsListProvider provider;
  final productsList = <Product>[];

  ScannerWidget({required this.provider, super.key});

  @override
  Widget build(BuildContext context) {
    final manager = ScaffoldMessenger.of(context);

    getUserInput(String codebar) async {
      return await getProductFromUser(context, codebar);
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPope) {
        context.pop(productsList);
      },
      child: Scaffold(
        body: MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
          ),
          onDetect: (barcodes) async {
            AudioPlayer().play(AssetSource('audio/beep.mp3'));
            final codebar = barcodes.barcodes[0].rawValue.toString();
            final product = await provider.getProductByCodebar(codebar);

            if (product != null) {
              productsList.add(product);
            } else {
              // manager.showSnackBar(const SnackBar(content: Text('')));
              final product = await getUserInput(codebar);
              if (product == null) {
                return;
              }
              final alreadyScanned = productsList.indexWhere(
                    (element) => element.codebar == product.codebar,
                  ) !=
                  -1;

              if (!alreadyScanned) {
                provider.addProduct(
                  product,
                  onSuccess: (id) {
                    productsList.add(product);
                  },
                  onFail: (e) {
                    logger.e(e);
                  },
                );
              } else {
                manager.showSnackBar(
                  const SnackBar(
                    content: Text('Produit deja dans la liste'),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
