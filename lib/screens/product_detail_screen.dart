import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${product.id}'),
            Text('الاسم: ${product.name}'),
            Text('الاسم المعروض: ${product.displayName}'),
            Text('تاريخ الإنشاء: ${product.createDate}'),
            Text('تاريخ التعديل: ${product.writeDate}'),
            Text('السعر: ${product.listPrice}'),
            if (product.image128 != null)
              Image.network(product.image128!),
          ],
        ),
      ),
    );
  }
}