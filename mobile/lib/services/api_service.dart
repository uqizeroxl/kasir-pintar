import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  
  static Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    try {
      debugPrint('Searching for products with query: $query');
      final response = await http.get(
        Uri.parse('$baseUrl/products/search/$query'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      
      debugPrint('API response status: ${response.statusCode}');
      debugPrint('API response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final results = data.map((item) => item as Map<String, dynamic>).toList();
        debugPrint('Found ${results.length} products');
        return results;
      } else {
        debugPrint('API request failed with status: ${response.statusCode}');
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error searching products: $e');
      // In case of network error, return empty list
      // In a real app, you might want to handle this differently
      return [];
    }
  }
}