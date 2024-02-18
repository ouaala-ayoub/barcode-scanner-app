import 'package:floor/floor.dart';

@entity
class Product {
  @primaryKey
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
}
