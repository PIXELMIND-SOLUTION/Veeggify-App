import 'package:flutter/foundation.dart';
import 'package:veegify/model/product_model.dart';
import 'package:veegify/services/wishlist_service.dart';

class WishlistProvider extends ChangeNotifier {
  List<Product> _wishlistItems = [];
  List<String> _wishlistIds = [];
  bool _isLoading = false;
  String _error = '';

  // Getters
  List<Product> get wishlistItems => _wishlistItems;
  List<dynamic> get wishlistIds => _wishlistIds;
  bool get isLoading => _isLoading;
  String get error => _error;
  int get wishlistCount => _wishlistItems.length;

  // Check if product is in wishlist
  bool isInWishlist(String productId) {
    return _wishlistIds.contains(productId);
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error state
  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = '';
    notifyListeners();
  }

  // Load wishlist
  Future<void> loadWishlist(String userId) async {
    _setLoading(true);
    _setError('');

    try {
      final response = await WishlistService.getWishlist(userId);
      
      if (response.wishlist != null) {
        _wishlistItems = response.wishlist!;
        _wishlistIds = _wishlistItems.map((item) => item.id).toList();
      } else {
        _wishlistItems = [];
        _wishlistIds = [];
      }
      
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  // Toggle wishlist item
  Future<bool> toggleWishlist(String userId, String productId) async {
    _setError('');

    try {
      final response = await WishlistService.toggleWishlist(userId, productId);
      
      if (response.isInWishlist != null) {
        if (response.isInWishlist!) {
          // Product was added to wishlist
          if (!_wishlistIds.contains(productId)) {
            _wishlistIds.add(productId);
          }
        } else {
          // Product was removed from wishlist
          _wishlistIds.remove(productId);
          _wishlistItems.removeWhere((item) => item.id == productId);
        }
        
        notifyListeners();
        return response.isInWishlist!;
      }
      
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // Remove specific item from wishlist
  Future<void> removeFromWishlist(String userId, String productId) async {
    _setError('');

    try {
      await WishlistService.removeFromWishlist(userId, productId);
      
      _wishlistIds.remove(productId);
      _wishlistItems.removeWhere((item) => item.id == productId);
      
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Clear all wishlist items (local only)
  void clearWishlist() {
    _wishlistItems.clear();
    _wishlistIds.clear();
    notifyListeners();
  }

  // Add product to local wishlist (when we have product details)
  void addProductToWishlist(Product product) {
    if (!_wishlistIds.contains(product.id)) {
      _wishlistItems.add(product);
      _wishlistIds.add(product.id);
      notifyListeners();
    }
  }
}