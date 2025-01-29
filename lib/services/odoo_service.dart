import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:odooproject/models/product.dart';
class OdooService {
  static OdooClient client = OdooClient('http://82.137.250.221:8075');

  static Future<void> initOdoo() async {
    try {
      await client.authenticate('dbtest03', 'omran', 'omran123');
      print("Odoo authentication successful");
    } on OdooException catch (e) {
      print("Odoo authentication failed: $e");
    }
  }

  static Future<List<Product>> fetchProducts() async {
    final response = await client.callKw({
      'model': 'product.product',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'fields': [
          'id',
          'name',
          'display_name',
          'create_date',
          'write_date',
          // 'image_128',
          'list_price'
        ],
      },
    });
    print("Fetched products: $response");
    if (response != null) {
      return (response as List).map((map) {
        print("Mapping product: $map");
        return Product.fromMap(map);
      }).toList();
    }
    throw "No data";
  }
}