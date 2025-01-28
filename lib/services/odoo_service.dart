import 'package:odoo_rpc/odoo_rpc.dart';
import '../models/product.dart';

class OdooService {
  final OdooClient odoo = OdooClient('http://82.137.250.221:8075');

  Future<void> authenticate() async {
    await odoo.authenticate('dbtest03', 'omran', 'omran123');
  }

  Future<List<Product>> fetchProducts() async {
    final response = await odoo.callKw({
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
          'image_128',
          'list_price'
        ],
      },
    });

    return (response as List).map((map) => Product.fromMap(map)).toList();
  }
}
