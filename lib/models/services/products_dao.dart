import 'package:floor/floor.dart';
import 'package:testapp/models/core/product.dart';

@dao
abstract class ProductsDao {
  @Query('SELECT * FROM Product')
  Future<List<Product>> getAllProducts();

  @Query("SELECT * FROM Product WHERE codebar == :codebar")
  Future<Product?> getProductByCodebar(String codebar);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> addProduct(Product product);

  @update
  Future<int> updateProduct(Product product);

  @delete
  Future<int> deleteProduct(Product product);
}
