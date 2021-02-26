import 'package:betta/models/model.dart';

enum ProductType { bottle, nipple, accessories }

class ProductModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final String category;
  final ProductType type;
  final double price;

  ProductModel(
    this.id,
    this.name,
    this.image,
    this.description,
    this.category,
    this.price,
    this.type,
  );

  static ProductType _setType(String type) {
    switch (type) {
      case 'bottle':
        return ProductType.bottle;
      case 'nipple':
        return ProductType.nipple;
      case 'accessories':
        return ProductType.accessories;
      default:
        return ProductType.bottle;
    }
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      json['id'] as int ?? 0,
      json['name'] as String ?? 'Unknown',
      json['image'] as String ?? 'Unknown',
      json['price'] as String ?? 0,
      json['description'] as String ?? 'Unknown',
      json['category'] as String ?? 0,
      _setType(json['type']),
    );
  }
}
