import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:testapp/models/core/db.dart';
import 'package:testapp/models/helpers/db_helpers.dart';
import 'package:testapp/providers/products_list_provider.dart';
import 'package:testapp/views/home.dart';
import 'package:testapp/views/products.dart';
import 'package:testapp/views/scan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dao =
      await $FloorProductsDataBase.databaseBuilder('products_db_1.db').build();

  runApp(MyApp(
    routes: routes(dao),
  ));
}

routes(ProductsDataBase db) {
  return GoRouter(
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
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => ProductsListProvider(
            helper: ProductsHelper(productDb: db),
          ),
          child: Consumer<ProductsListProvider>(
            builder: (context, provider, child) =>
                ProductsPage(provider: provider),
          ),
        ),
      ),
    ],
  );
}

final logger = Logger();

class MyApp extends StatelessWidget {
  final routes;
  const MyApp({required this.routes, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
