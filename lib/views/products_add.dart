// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:testapp/main.dart';
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
                widget.provider.addProduct(product, onSuccess: (id) {
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
