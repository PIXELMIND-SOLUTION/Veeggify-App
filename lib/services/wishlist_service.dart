import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:veegify/model/wishlist_model.dart';

class WishlistService {
  static const String baseUrl = 'https://vegifyy-backend-2.onrender.com/api';
  
  // Toggle wishlist (add or remove)
  static Future<WishlistResponse> toggleWishlist(String userId, String productId) async {
    try {

      final response = await http.post(
        Uri.parse('$baseUrl/wishlist/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'productId': productId,
        }),
      );

      if (response.statusCode == 200) {
        return WishlistResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to toggle wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error toggling wishlist: $e');
    }
  }

  // Get wishlist
  static Future<WishlistResponse> getWishlist(String userId) async {
    try {

                        print("URL: ${'$baseUrl/wishlist/$userId'}");

      final response = await http.get(
        Uri.parse('$baseUrl/wishlist/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

                  print("URL: ${'$baseUrl/wishlist/$userId'}");


      if (response.statusCode == 200) {
        return WishlistResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting wishlist: $e');
    }
  }

  // Remove specific product from wishlist
  static Future<WishlistResponse> removeFromWishlist(String userId, String productId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/wishlist/$userId/$productId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return WishlistResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to remove from wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error removing from wishlist: $e');
    }
  }
}