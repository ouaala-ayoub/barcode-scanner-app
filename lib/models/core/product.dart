import 'package:floor/floor.dart';

@entity
class Product {
  @PrimaryKey(autoGenerate: true)
  int? id;

  String codebar;
  double price;
  String name;
  int quantity;

  Product(
      {this.id,
      required this.codebar,
      required this.price,
      required this.name,
      required this.quantity});

  @override
  String toString() {
    return 'Product(id:$id, codebar:$codebar, price:$price, name:$name, quantity:$quantity)';
  }

  static bool areTheSame(Product product1, Product product2) =>
      product1.id == product2.id &&
      product1.codebar == product2.codebar &&
      product1.name == product2.name &&
      product1.price == product2.price &&
      product1.quantity == product2.quantity;
}
