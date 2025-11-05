// services/restaurant_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:veegify/model/restaurant_product_model.dart';

class RestaurantService {
  static const String _baseUrl = 'http://31.97.206.144:5051/api';

  static Future<RestaurantProductResponse> getRestaurantProducts(String restaurantId) async {
    print('Restaurant ID: $restaurantId');
    try {
          print('jjjjjjjjjjjjjjjjjjj ID: $restaurantId');

      final response = await http.get(
        Uri.parse('$_baseUrl/restaurant-products/$restaurantId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print("Response statusss code: ${response.statusCode}");
      print("Response statusss code: ${response.body}");


      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return RestaurantProductResponse.fromJson(data);
      } else {
        throw Exception('Failed to load restaurant products: ${response.statusCode}');
      }
    } catch (e) {          print('jjjjjjjjjjjjjjjjjjj yyyyyyyyyyyyyyyyyyy');


      throw Exception('Error fetching restaurant products: $e');
    }
  }
}