class Product {
  final int id;
  final String name;
  final String displayName;
  final String createDate;
  final String writeDate;
  final String? image128;
  final double listPrice;

  Product({
    required this.id,
    required this.name,
    required this.displayName,
    required this.createDate,
    required this.writeDate,
    this.image128,
    required this.listPrice,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      displayName: map['display_name'],
      createDate: map['create_date'],
      writeDate: map['write_date'],
      image128: map['image_128'],
      listPrice: map['list_price'],
    );
  }
}