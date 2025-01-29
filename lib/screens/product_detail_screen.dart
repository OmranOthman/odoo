import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Not available';
    final date = DateTime.tryParse(dateString);
    return date != null
        ? DateFormat('yyyy/MM/dd - hh:mm a').format(date)
        : 'Invalid format';
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (product.image128 != null)
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    product.image128!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              )
            else
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildDetailRow('ID', '#${product.id}', context),
                          const Divider(),
                          _buildDetailRow('Full Name', product.displayName, context),
                          const Divider(),
                          _buildDetailRow(
                            'Price',
                            '${product.listPrice?.toStringAsFixed(2) ?? 'N/A'} SAR',
                            context,
                            valueColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dates',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildDetailRow('Creation Date', _formatDate(product.createDate), context),
                          const Divider(),
                          _buildDetailRow('Last Modified Date', _formatDate(product.writeDate), context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, BuildContext context, {Color? valueColor}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: valueColor ?? (isDarkMode ? Colors.white : Colors.black),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}