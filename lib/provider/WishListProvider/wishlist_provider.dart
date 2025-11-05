import 'package:flutter/material.dart';
import 'package:veegify/model/wishlist_model.dart';
import 'package:veegify/services/wishlist_service.dart';

class WishlistProvider extends ChangeNotifier {
  List<WishlistProduct> _wishlist = [];
  bool _isLoading = false;
  String _error = '';

  List<WishlistProduct> get wishlist => _wishlist;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchWishlist(String userId) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      print("oooooooooooooo$userId");
      _wishlist = await WishlistService.getWishlist(userId);
            notifyListeners();

    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleWishlist(String userId, String productId) async {
    try {
      print("Printing User Id : $userId");
      print("Printing Product Id: $productId");
      final isInWishlist =
          await WishlistService.toggleWishlist(userId, productId);

      if (isInWishlist) {
        // only add if not already in list
        final product = await WishlistService.getProduct(productId);
        if (!_wishlist.any((item) => item.id == product.id)) {
          _wishlist.add(product);
        }
      } else {
        _wishlist.removeWhere((item) => item.id == productId);
      }

      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  bool isInWishlist(String productId) {
    return _wishlist.any((item) => item.id == productId);
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }
}
