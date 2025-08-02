// providers/restaurant_provider.dart

import 'package:flutter/material.dart';
import 'package:veegify/model/restaurant_product_model.dart';
import 'package:veegify/services/restaurant_product_service.dart';


class RestaurantProductsProvider with ChangeNotifier {
  List<RestaurantProduct> _products = [];
  bool _isLoading = false;
  String? _error;
  String _restaurantName = '';
  String _locationName = '';
  double _rating = 0.0;
  TimeAndDistance? _timeAndDistance;

  // Getters
  List<RestaurantProduct> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get restaurantName => _restaurantName;
  String get locationName => _locationName;
  double get rating => _rating;
  TimeAndDistance? get timeAndDistance => _timeAndDistance;

  // Get recommended items from all products
  List<RecommendedItem> get allRecommendedItems {
    List<RecommendedItem> allItems = [];
    for (var product in _products) {
      allItems.addAll(product.recommended);
    }
    return allItems;
  }

  Future<void> fetchRestaurantProducts(String restaurantId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await RestaurantService.getRestaurantProducts(restaurantId);
      
      if (response.success && response.data.isNotEmpty) {
        _products = response.data;
        
        // Set restaurant info from the first product
        final firstProduct = response.data.first;
        _restaurantName = firstProduct.restaurantName;
        _locationName = firstProduct.locationName;
        _rating = firstProduct.rating;
        _timeAndDistance = firstProduct.timeAndKm;
        
        _error = null;
      } else {
        _error = response.message.isEmpty ? 'No products found' : response.message;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearData() {
    _products = [];
    _error = null;
    _restaurantName = '';
    _locationName = '';
    _rating = 0.0;
    _timeAndDistance = null;
    notifyListeners();
  }

  // Search functionality
  List<RecommendedItem> searchItems(String query) {
    if (query.isEmpty) return allRecommendedItems;
    
    return allRecommendedItems.where((item) => 
      item.name.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}