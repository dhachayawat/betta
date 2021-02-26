import 'package:flutter/cupertino.dart';
import 'package:betta/models/model.dart';
import 'package:betta/utils/utils.dart';

class CategoryModel {
  final int id;
  final String title;
  final int count;
  final String image;
  final IconData icon;
  final Color color;
  final ProductType type;

  CategoryModel({
    this.id,
    this.title,
    this.count,
    this.image,
    this.icon,
    this.color,
    this.type,
  });

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

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final icon = UtilIcon.getIconData(json['icon'] ?? "Unknown");
    final color = UtilColor.getColorFromHex(json['color'] ?? "#ff8a65");
    return CategoryModel(
      id: json['id'] as int ?? 0,
      title: json['title'] as String ?? 'Unknown',
      count: json['count'] as int ?? 0,
      image: json['image'] as String ?? 'Unknown',
      icon: icon,
      color: color,
      type: _setType(json['type'] as String ?? "Unknown"),
    );
  }
}
