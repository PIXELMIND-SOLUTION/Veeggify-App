// services/restaurant_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:veegify/model/restaurant_product_model.dart';

class RestaurantService {
  static const String _baseUrl = 'https://vegifyy-backend-2.onrender.com/api';

  static Future<RestaurantProductResponse> getRestaurantProducts(String restaurantId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/restaurant-products/$restaurantId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return RestaurantProductResponse.fromJson(data);
      } else {
        throw Exception('Failed to load restaurant products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching restaurant products: $e');
    }
  }
}