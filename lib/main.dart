import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:testapp/models/core/db.dart';
import 'package:testapp/models/helpers/db_helpers.dart';
import 'package:testapp/providers/products_list_provider.dart';
import 'package:testapp/views/home.dart';
import 'package:testapp/views/products.dart';
import 'package:testapp/views/products_add.dart';
import 'package:testapp/views/scan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dao =
      await $FloorProductsDataBase.databaseBuilder('products_db.db').build();

  runApp(MyApp(
    helper: ProductsHelper(productDb: dao),
  ));
}

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/scan',
      builder: (context, state) => const ScanPage(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => Consumer<ProductsListProvider>(
        builder: (context, provider, child) => ProductsPage(provider: provider),
      ),
    ),
    GoRoute(
      path: '/products/add',
      builder: (context, state) => Consumer<ProductsListProvider>(
        builder: (context, provider, child) => ProductsAdd(provider: provider),
      ),
    )
  ],
);

final logger = Logger();

class MyApp extends StatelessWidget {
  final ProductsHelper helper;
  const MyApp({required this.helper, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductsListProvider(helper: helper),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
