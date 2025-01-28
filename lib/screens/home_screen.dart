import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';
import '../services/odoo_service.dart';
import '../services/database_service.dart';
import 'product_detail_screen.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final odooService = OdooService();
    await odooService.authenticate();
    final products = await odooService.fetchProducts();

    final dbService = DatabaseService();
    await dbService.initDb();
    await dbService.saveProducts(products);

    setState(() {
      this.products = products;
      this.filteredProducts = products;
    });
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المنتجات'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'بحث',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: filterProducts,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.displayName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
