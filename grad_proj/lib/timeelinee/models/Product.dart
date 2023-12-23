import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../config.dart';

class Product {
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    this.images = const ['assets/car1.json'],
    this.colors = const [Color(0xFF00FF00), Color(0xFF0000FF)],
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      images: List<String>.from(json['images'] ?? ['assets/car1.json']),
      colors: List<Color>.from(json['colors']?.map((color) => Color(color)) ??
          [
            Color(0xFF00FF00),
            Color(0xFF0000FF),
          ]),
      title: json['Name'] ?? '',
      rating: json['rate']?.toDouble() ?? 0.0,
      price: json['price']?.toDouble() ?? 0.0,
      description: json['descrption'] ?? '',
    );
  }
}

class ProductService {
  static Future<List<Product>> getProductsByCompany(String company) async {
    final response = await http.get(
      Uri.parse('$getyoerprodact/$company'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
