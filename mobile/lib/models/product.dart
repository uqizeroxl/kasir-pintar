import 'package:flutter/foundation.dart';

class Product {
  final int id;
  final String name;
  final String sku;
  final String description;
  final double price;
  final double costPrice;
  final int stockQuantity;
  final int categoryId;
  final bool isActive;
  final String categoryName;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.description,
    required this.price,
    required this.costPrice,
    required this.stockQuantity,
    required this.categoryId,
    required this.isActive,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    debugPrint('Creating Product from JSON: $json');
    final product = Product(
      id: json['id'],
      name: json['name'],
      sku: json['sku'],
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      costPrice: (json['cost_price'] as num?)?.toDouble() ?? 0.0,
      stockQuantity: json['stock_quantity'],
      categoryId: json['category_id'],
      isActive: json['is_active'] ?? true,
      categoryName: json['category_name'] ?? 'Unknown',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
    debugPrint('Created Product: ${product.name} (${product.sku})');
    return product;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'description': description,
      'price': price,
      'cost_price': costPrice,
      'stock_quantity': stockQuantity,
      'category_id': categoryId,
      'is_active': isActive,
      'category_name': categoryName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}