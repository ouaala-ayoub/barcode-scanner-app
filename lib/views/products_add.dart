import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:testapp/main.dart';
import 'package:testapp/models/helpers/functions_helper.dart';
import 'package:testapp/providers/products_list_provider.dart';

bool added = false;

class ProductsAdd extends StatelessWidget {
  final ProductsListProvider provider;
  final controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  ProductsAdd({required this.provider, super.key});

  @override
  Widget build(BuildContext context) {
    pop() {
      context.pop();
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => context.pop(added),
      child: Scaffold(
        body: MobileScanner(
          controller: controller,
          onDetect: (barcodes) async {
            final codeBar = barcodes.barcodes[0].rawValue;
            logger.i(codeBar);
            if (codeBar != null) {
              final product = await getProductFromUser(context, codeBar);
              if (product != null) {
                logger.d(product);
                provider.addProduct(product, onSuccess: (id) {
                  // context.pop(true);
                  controller.start(cameraFacingOverride: CameraFacing.back);
                  added = true;
                }, onFail: (e) {
                  context.pop();
                });
              } else {
                //!async pop
                pop();
              }
            } else {
              context.pop();
            }
            // context.pop();
          },
        ),
      ),
    );
  }
}
