import 'package:dartz/dartz.dart';
import 'package:testapp/main.dart';
import 'package:testapp/models/core/db.dart';
import 'package:testapp/models/core/product.dart';

class ProductsHelper {
  ProductsDataBase productDb;
  ProductsHelper({required this.productDb});

  Future<Either<dynamic, List<Product>>> getAllProducts() async {
    try {
      final products = await productDb.productsDao.getAllProducts();
      return Right(products);
    } catch (e) {
      logger.e(e);
      return Left(e);
    }
  }

  Future<Either<dynamic, int>> addProduct(Product product) async {
    try {
      final insertedId = await productDb.productsDao.addProduct(product);
      return Right(insertedId);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, int>> deleteProduct(Product product) async {
    try {
      final deletedId = await productDb.productsDao.deleteProduct(product);
      return Right(deletedId);
    } catch (e) {
      return Left(e);
    }
  }
}
