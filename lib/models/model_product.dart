import 'package:betta/models/model.dart';

enum ProductType { bottle, nipple, accessories }

class ProductModel {
  final int id;
  final String name;
  final String nameTH;
  final String description;
  final String descriptionTH;
  final String image;
  final String category;
  final ProductType type;
  final num price;

  ProductModel(
    this.id,
    this.name,
    this.nameTH,
    this.image,
    this.description,
    this.descriptionTH,
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
      json['nameTH'] as String ?? 'Unknown',
      json['image'] as String ?? 'Unknown',
      json['description'] as String ?? 'Unknown',
      json['descriptionTH'] as String ?? 'Unknown',
      json['category'] as String ?? 0,
      json['price'] as num ?? 0,
      _setType(json['type']),
    );
  }
}
