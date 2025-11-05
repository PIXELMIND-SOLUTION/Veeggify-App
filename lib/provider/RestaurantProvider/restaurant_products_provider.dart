// // providers/restaurant_provider.dart

// import 'package:flutter/material.dart';
// import 'package:veegify/model/restaurant_product_model.dart';
// import 'package:veegify/services/restaurant_product_service.dart';


// class RestaurantProductsProvider with ChangeNotifier {
//   List<RestaurantProduct> _products = [];
//   bool _isLoading = false;
//   String? _error;
//   String _restaurantName = '';
//   String _locationName = '';
//   double _rating = 0.0;
//   TimeAndDistance? _timeAndDistance;

//   // Getters
//   List<RestaurantProduct> get products => _products;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   String get restaurantName => _restaurantName;
//   String get locationName => _locationName;
//   double get rating => _rating;
//   TimeAndDistance? get timeAndDistance => _timeAndDistance;

//   // Get recommended items from all products
//   List<RecommendedItem> get allRecommendedItems {
//     List<RecommendedItem> allItems = [];
//     for (var product in _products) {
//       allItems.addAll(product.recommended);
//     }
//     return allItems;
//   }

//   Future<void> fetchRestaurantProducts(String restaurantId) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       print("Res ID:  $restaurantId");
//       final response = await RestaurantService.getRestaurantProducts(restaurantId);
      
//       if (response.success && response.data.isNotEmpty) {
//         _products = response.data;
        
//         // Set restaurant info from the first product
//         final firstProduct = response.data.first;
//         _restaurantName = firstProduct.restaurantName;
//         _locationName = firstProduct.locationName;
//         _rating = firstProduct.rating;
//         _timeAndDistance = firstProduct.timeAndKm;
        
//         _error = null;
//       } else {
//         _error = response.message.isEmpty ? 'No products found' : response.message;
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   void clearData() {
//     _products = [];
//     _error = null;
//     _restaurantName = '';
//     _locationName = '';
//     _rating = 0.0;
//     _timeAndDistance = null;
//     notifyListeners();
//   }

//   // Search functionality
//   List<RecommendedItem> searchItems(String query) {
//     if (query.isEmpty) return allRecommendedItems;
    
//     return allRecommendedItems.where((item) => 
//       item.name.toLowerCase().contains(query.toLowerCase())
//     ).toList();
//   }
// }














// import 'package:flutter/material.dart';
// import 'package:veegify/model/restaurant_product_model.dart';
// import 'package:veegify/services/restaurant_product_service.dart';

// class RestaurantProductsProvider with ChangeNotifier {
//   List<RecommendedProduct> _recommendedProducts = [];
//   bool _isLoading = false;
//   String? _error;
//   String _restaurantName = '';
//   String _locationName = '';
//   double _rating = 0.0;
//   int _totalRecommendedItems = 0;

//   // Getters
//   List<RecommendedProduct> get recommendedProducts => _recommendedProducts;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   String get restaurantName => _restaurantName;
//   String get locationName => _locationName;
//   double get rating => _rating;
//   int get totalRecommendedItems => _totalRecommendedItems;

//   // Get all recommended items for display
//   List<RecommendedItem> get allRecommendedItems {
//     return _recommendedProducts.map((product) => product.recommendedItem).toList();
//   }

//   Future<void> fetchRestaurantProducts(String restaurantId) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       print("Fetching products for restaurant ID: $restaurantId");
//       final response = await RestaurantService.getRestaurantProducts(restaurantId);
      
//       if (response.success && response.recommendedProducts.isNotEmpty) {
//         _recommendedProducts = response.recommendedProducts;
//         _totalRecommendedItems = response.totalRecommendedItems;
        
//         // Set restaurant info from the first product
//         final firstProduct = response.recommendedProducts.first;
//         _restaurantName = firstProduct.restaurantName;
//         _locationName = firstProduct.locationName;
//         _rating = firstProduct.rating;
        
//         _error = null;
//       } else {
//         _error = 'No recommended products found';
//         _recommendedProducts = [];
//         _totalRecommendedItems = 0;
//       }
//     } catch (e) {
//       _error = e.toString();
//       _recommendedProducts = [];
//       _totalRecommendedItems = 0;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   void clearData() {
//     _recommendedProducts = [];
//     _error = null;
//     _restaurantName = '';
//     _locationName = '';
//     _rating = 0.0;
//     _totalRecommendedItems = 0;
//     notifyListeners();
//   }

//   // Search functionality
//   List<RecommendedItem> searchItems(String query) {
//     if (query.isEmpty) return allRecommendedItems;
    
//     return allRecommendedItems.where((item) => 
//       item.name.toLowerCase().contains(query.toLowerCase()) ||
//       item.category.categoryName.toLowerCase().contains(query.toLowerCase())
//     ).toList();
//   }

//   // Get product by recommended item
//   RecommendedProduct? getProductByRecommendedItem(RecommendedItem item) {
//     try {
//       return _recommendedProducts.firstWhere(
//         (product) => product.recommendedItem.name == item.name
//       );
//     } catch (e) {
//       return null;
//     }
//   }
// }








import 'package:flutter/material.dart';
import 'package:veegify/model/restaurant_product_model.dart';
import 'package:veegify/services/restaurant_product_service.dart';

class RestaurantProductsProvider with ChangeNotifier {
  List<RecommendedProduct> _recommendedProducts = [];
  bool _isLoading = false;
  String? _error;
  String _restaurantName = '';
  String _locationName = '';
  double _rating = 0.0;
  int _totalRecommendedItems = 0;

  // Getters
  List<RecommendedProduct> get recommendedProducts => _recommendedProducts;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get restaurantName => _restaurantName;
  String get locationName => _locationName;
  double get rating => _rating;
  int get totalRecommendedItems => _totalRecommendedItems;

  // Get all recommended items for display with their product IDs
  List<RecommendedItemWithId> get allRecommendedItems {
    return _recommendedProducts.map((product) => RecommendedItemWithId(
      productId: product.productId,
      recommendedItem: product.recommendedItem,
    )).toList();
  }

  Future<void> fetchRestaurantProducts(String restaurantId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      print("Fetching products for restaurant ID: $restaurantId");
      final response = await RestaurantService.getRestaurantProducts(restaurantId);
      
      if (response.success && response.recommendedProducts.isNotEmpty) {
        _recommendedProducts = response.recommendedProducts;
        _totalRecommendedItems = response.totalRecommendedItems;
        
        // Set restaurant info from the first product
        final firstProduct = response.recommendedProducts.first;
        _restaurantName = firstProduct.restaurantName;
        _locationName = firstProduct.locationName;
        _rating = firstProduct.rating;
        
        _error = null;
      } else {
        _error = 'No recommended products found';
        _recommendedProducts = [];
        _totalRecommendedItems = 0;
      }
    } catch (e) {
      _error = e.toString();
      _recommendedProducts = [];
      _totalRecommendedItems = 0;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearData() {
    _recommendedProducts = [];
    _error = null;
    _restaurantName = '';
    _locationName = '';
    _rating = 0.0;
    _totalRecommendedItems = 0;
    notifyListeners();
  }

  // Search functionality
  List<RecommendedItemWithId> searchItems(String query) {
    if (query.isEmpty) return allRecommendedItems;
    
    return allRecommendedItems.where((itemWithId) =>
      itemWithId.recommendedItem.name.toLowerCase().contains(query.toLowerCase()) ||
      itemWithId.recommendedItem.category.categoryName.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // Get product by recommended item name
  RecommendedProduct? getProductByRecommendedItem(RecommendedItem item) {
    try {
      return _recommendedProducts.firstWhere(
        (product) => product.recommendedItem.name == item.name
      );
    } catch (e) {
      return null;
    }
  }

  // Get product ID by recommended item name
  String? getProductIdByItem(RecommendedItem item) {
    final product = getProductByRecommendedItem(item);
    return product?.productId; // This returns the productId from the API
  }
}




// import 'package:flutter/material.dart';
// import 'package:veegify/model/restaurant_product_model.dart';
// import 'package:veegify/services/restaurant_product_service.dart';

// class RestaurantProductsProvider with ChangeNotifier {
//   List<RestaurantProduct> _products = [];
//   bool _isLoading = false;
//   String? _error;
//   String _restaurantName = '';
//   String _locationName = '';
//   double _rating = 0.0;

//   // Getters
//   List<RestaurantProduct> get products => _products;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   String get restaurantName => _restaurantName;
//   String get locationName => _locationName;
//   double get rating => _rating;

//   // Get recommended items from all products
//   List<RecommendedItem> get allRecommendedItems {
//     return _products.map((p) => p.recommendedItem).toList();
//   }

//   Future<void> fetchRestaurantProducts(String restaurantId) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final response = await RestaurantService.getRestaurantProducts(restaurantId);

//       if (response.success && response.recommendedProducts.isNotEmpty) {
//         _products = response.recommendedProducts;

//         // Set restaurant info from the first product
//         final firstProduct = _products.first;
//         _restaurantName = firstProduct.restaurantName;
//         _locationName = firstProduct.locationName;
//         _rating = firstProduct.rating;

//         _error = null;
//       } else {
//         _error = 'No products found';
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   void clearData() {
//     _products = [];
//     _error = null;
//     _restaurantName = '';
//     _locationName = '';
//     _rating = 0.0;
//     notifyListeners();
//   }

//   // Search functionality
//   List<RecommendedItem> searchItems(String query) {
//     if (query.isEmpty) return allRecommendedItems;

//     return allRecommendedItems
//         .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }
// }
