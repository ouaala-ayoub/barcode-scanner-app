import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Barcode App')),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                child: Text('Mes Produits'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                child: Text('Scan'),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
