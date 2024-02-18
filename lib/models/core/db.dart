import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../services/products_dao.dart';
import './product.dart';

part 'db.g.dart';

@Database(version: 1, entities: [Product])
abstract class ProductsDataBase extends FloorDatabase {
  ProductsDao get productsDao;
}
