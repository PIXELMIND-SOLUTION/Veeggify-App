// cart_model.dart
import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final String image;
  final int basePrice;
  final String variation;
  final Set<String> addOns;
  final int quantity;
  final bool isVeg;

  CartItem({
    required this.id,
    required this.title,
    required this.image,
    required this.basePrice,
    required this.variation,
    required this.addOns,
    required this.quantity,
    required this.isVeg,
  });

  int get totalPrice {
    int base = variation == 'Half' ? basePrice : (basePrice * 1.4).round();
    int addOnPrice = 0;
    if (addOns.contains('1 Plate')) addOnPrice += 5;
    if (addOns.contains('2 Plates')) addOnPrice += 10;
    return (base + addOnPrice) * quantity;
  }

  CartItem copyWith({
    String? id,
    String? title,
    String? image,
    int? basePrice,
    String? variation,
    Set<String>? addOns,
    int? quantity,
    bool? isVeg,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      basePrice: basePrice ?? this.basePrice,
      variation: variation ?? this.variation,
      addOns: addOns ?? this.addOns,
      quantity: quantity ?? this.quantity,
      isVeg: isVeg ?? this.isVeg,
    );
  }
}


class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  int get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  int get deliveryCharge => _items.isEmpty ? 0 : 22;

  int get totalPayable => subtotal + deliveryCharge;

  void addItem(CartItem item) {
    // Check if similar item exists (same dish, variation, and add-ons)
    final existingIndex = _items.indexWhere((existingItem) =>
        existingItem.title == item.title &&
        existingItem.variation == item.variation &&
        existingItem.addOns.length == item.addOns.length &&
        existingItem.addOns.every((addOn) => item.addOns.contains(addOn)));

    if (existingIndex >= 0) {
      // Update quantity of existing item
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + item.quantity,
      );
    } else {
      // Add new item
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(itemId);
      return;
    }

    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: newQuantity);
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}