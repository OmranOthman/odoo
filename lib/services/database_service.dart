import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart'
    show ConflictAlgorithm, Database, getDatabasesPath, openDatabase;
import '../models/product.dart';
class DatabaseService {
  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'products.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        print("Creating database table...");
        return db.execute(
          'CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, display_name TEXT, create_date TEXT, write_date TEXT, image_128 TEXT, list_price REAL)',
        );
      },
      version: 1,
    );
  }

  Future<void> saveProducts(List<Product> products) async {
    final db = await initDb();
    for (var product in products) {
      print('Saving product: ${product.name}');
      await db.insert(
        'products',
        {
          'id': product.id,
          'name': product.name,
          'display_name': product.displayName,
          'create_date': product.createDate,
          'write_date': product.writeDate,
          'image_128': product.image128,
          'list_price': product.listPrice,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> printAllProducts() async {
    final db = await initDb();
    final List<Map<String, dynamic>> products = await db.query('products');
    print('All Products in DB: $products');
  }

  Future<List<Product>> getProducts() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }
}