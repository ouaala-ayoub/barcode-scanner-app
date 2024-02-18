// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorProductsDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ProductsDataBaseBuilder databaseBuilder(String name) =>
      _$ProductsDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ProductsDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$ProductsDataBaseBuilder(null);
}

class _$ProductsDataBaseBuilder {
  _$ProductsDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$ProductsDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ProductsDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ProductsDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ProductsDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ProductsDataBase extends ProductsDataBase {
  _$ProductsDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductsDao? _productsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Product` (`id` INTEGER, `codebar` TEXT NOT NULL, `price` REAL NOT NULL, `name` TEXT NOT NULL, `quantity` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductsDao get productsDao {
    return _productsDaoInstance ??= _$ProductsDao(database, changeListener);
  }
}

class _$ProductsDao extends ProductsDao {
  _$ProductsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productInsertionAdapter = InsertionAdapter(
            database,
            'Product',
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'codebar': item.codebar,
                  'price': item.price,
                  'name': item.name,
                  'quantity': item.quantity
                }),
        _productUpdateAdapter = UpdateAdapter(
            database,
            'Product',
            ['id'],
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'codebar': item.codebar,
                  'price': item.price,
                  'name': item.name,
                  'quantity': item.quantity
                }),
        _productDeletionAdapter = DeletionAdapter(
            database,
            'Product',
            ['id'],
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'codebar': item.codebar,
                  'price': item.price,
                  'name': item.name,
                  'quantity': item.quantity
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Product> _productInsertionAdapter;

  final UpdateAdapter<Product> _productUpdateAdapter;

  final DeletionAdapter<Product> _productDeletionAdapter;

  @override
  Future<List<Product>> getAllProducts() async {
    return _queryAdapter.queryList('SELECT * FROM Product',
        mapper: (Map<String, Object?> row) => Product(
            id: row['id'] as int?,
            codebar: row['codebar'] as String,
            price: row['price'] as double,
            name: row['name'] as String,
            quantity: row['quantity'] as int));
  }

  @override
  Future<Product?> getProductByCodebar(String codebar) async {
    return _queryAdapter.query('SELECT * FROM Product WHERE codebar == ?1',
        mapper: (Map<String, Object?> row) => Product(
            id: row['id'] as int?,
            codebar: row['codebar'] as String,
            price: row['price'] as double,
            name: row['name'] as String,
            quantity: row['quantity'] as int),
        arguments: [codebar]);
  }

  @override
  Future<int> addProduct(Product product) {
    return _productInsertionAdapter.insertAndReturnId(
        product, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateProduct(Product product) {
    return _productUpdateAdapter.updateAndReturnChangedRows(
        product, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteProduct(Product product) {
    return _productDeletionAdapter.deleteAndReturnChangedRows(product);
  }
}
