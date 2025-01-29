import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odooproject/models/product.dart';
import '../services/database_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = DatabaseService().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Product in DataBase'),
      ),
      body: FutureBuilder<List<Product>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available.'));
          }

          final products = snapshot.data!;
          return SingleChildScrollView(
            child: DataTable(
              columnSpacing: 16.0,
              dataRowHeight: 60.0,
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Display Name')),
                DataColumn(label: Text('Price')),
              ],
              rows: products.map((product) {
                return DataRow(
                  cells: [
                    DataCell(Text(product.name)),
                    DataCell(Text(product.displayName)),
                    DataCell(Text('\$${product.listPrice.toStringAsFixed(2)}')),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
