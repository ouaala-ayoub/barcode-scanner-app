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
}
