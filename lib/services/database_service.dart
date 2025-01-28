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
}
