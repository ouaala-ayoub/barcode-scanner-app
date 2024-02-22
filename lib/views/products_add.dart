// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:testapp/models/helpers/functions_helper.dart';
import 'package:testapp/providers/products_list_provider.dart';

class ProductsAdd extends StatefulWidget {
  final ProductsListProvider provider;

  const ProductsAdd({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  State<ProductsAdd> createState() => _ProductsAddState();
}

class _ProductsAddState extends State<ProductsAdd> {
  bool added = false;

  final controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  Widget build(BuildContext context) {
    getProduct(String codebar) async {
      return await getProductFromUser(context, codebar);
    }

    final manager = ScaffoldMessenger.of(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => context.pop(added),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scanner pour ajouter des produits'),
        ),
        body: MobileScanner(
          controller: controller,
          onDetect: (barcodes) async {
            final codeBar = barcodes.barcodes[0].rawValue;
            if (codeBar != null) {
              final foundProduct =
                  await widget.provider.getProductByCodebar(codeBar);

              if (foundProduct == null) {
                final product = await getProduct(codeBar);
                if (product == null) {
                  return;
                }
                widget.provider.addProduct(
                  product,
                  onSuccess: (id) {
                    // context.pop(true);
                    controller.start(cameraFacingOverride: CameraFacing.back);
                    added = true;
                  },
                  onFail: (e) {
                    manager.showSnackBar(
                      const SnackBar(
                        content: Text('Erreur en ajoutant le produit'),
                      ),
                    );
                    context.pop();
                  },
                );
              } else {
                manager.showSnackBar(
                  const SnackBar(
                    content: Text('Produit deja dans la base de données'),
                  ),
                );
              }
            } else {
              manager.showSnackBar(
                const SnackBar(
                  content: Text('Erreur de scan'),
                ),
              );
              context.pop();
            }
            // context.pop();
          },
        ),
      ),
    );
  }
}
