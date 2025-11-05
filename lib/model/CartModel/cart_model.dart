
// // models/cart_model.dart
// class CartModel {
//   final String id;
//   final String userId;
//   final List<CartProduct> products;
//   final int subTotal;
//   final int deliveryCharge;
//   final int couponDiscount;
//   final int finalAmount;
//   final int totalItems;
//   final String? appliedCouponId;
//   final DateTime createdAt;
//   final String restaurantId;

//   CartModel({
//     required this.id,
//     required this.userId,
//     required this.products,
//     required this.subTotal,
//     required this.deliveryCharge,
//     required this.couponDiscount,
//     required this.finalAmount,
//     required this.totalItems,
//     this.appliedCouponId,
//     required this.createdAt,
//     required this.restaurantId,
//   });

//   factory CartModel.fromJson(Map<String, dynamic> json) {
//     // Handle userId - it can be either a string or an object
//     String userIdValue = '';
//     if (json['userId'] is String) {
//       userIdValue = json['userId'];
//     } else if (json['userId'] is Map<String, dynamic>) {
//       userIdValue = json['userId']['_id'] ?? json['userId']['id'] ?? '';
//     }

//     return CartModel(
//       id: json['_id'] ?? '',
//       userId: userIdValue,
//       products: (json['products'] as List?)
//           ?.map((item) => CartProduct.fromJson(item))
//           .toList() ?? [],
//       subTotal: json['subTotal'] ?? 0,
//       deliveryCharge: json['deliveryCharge'] ?? 0,
//       couponDiscount: json['couponDiscount'] ?? 0,
//       finalAmount: json['finalAmount'] ?? 0,
//       totalItems: json['totalItems'] ?? 0,
//       appliedCouponId: json['appliedCouponId'],
//       createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
//       restaurantId: json['restaurantId'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'userId': userId,
//       'products': products.map((item) => item.toJson()).toList(),
//       'subTotal': subTotal,
//       'deliveryCharge': deliveryCharge,
//       'couponDiscount': couponDiscount,
//       'finalAmount': finalAmount,
//       'totalItems': totalItems,
//       'appliedCouponId': appliedCouponId,
//       'createdAt': createdAt.toIso8601String(),
//       'restaurantId': restaurantId,
//     };
//   }
// }

// class CartProduct {
//   final String id;
//   final String restaurantProductId;
//   final String recommendedId;
//   final int quantity;
//   final CartAddOn addOn;
//   final String name;
//   final int basePrice;
//   final int platePrice;
//   final String image;

//   CartProduct({
//     required this.id,
//     required this.restaurantProductId,
//     required this.recommendedId,
//     required this.quantity,
//     required this.addOn,
//     required this.name,
//     required this.basePrice,
//     required this.platePrice,
//     required this.image,
//   });

//   factory CartProduct.fromJson(Map<String, dynamic> json) {
//     // Handle restaurantProductId - it can be either a string or an object
//     String restaurantProductIdValue = '';
//     if (json['restaurantProductId'] is String) {
//       restaurantProductIdValue = json['restaurantProductId'];
//     } else if (json['restaurantProductId'] is Map<String, dynamic>) {
//       restaurantProductIdValue = json['restaurantProductId']['_id'] ?? 
//                                json['restaurantProductId']['id'] ?? '';
//     }

//     return CartProduct(
//       id: json['_id'] ?? '',
//       restaurantProductId: restaurantProductIdValue,
//       recommendedId: json['recommendedId'] ?? '',
//       quantity: json['quantity'] ?? 1,
//       addOn: CartAddOn.fromJson(json['addOn'] ?? {}),
//       name: json['name'] ?? '',
//       basePrice: json['basePrice'] ?? 0,
//       platePrice: json['platePrice'] ?? 0,
//       image: json['image'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'restaurantProductId': restaurantProductId,
//       'recommendedId': recommendedId,
//       'quantity': quantity,
//       'addOn': addOn.toJson(),
//       'name': name,
//       'basePrice': basePrice,
//       'platePrice': platePrice,
//       'image': image,
//     };
//   }

//   // Calculate total price for this product
//   int get totalPrice {
//     int variationPrice = basePrice;
//     if (addOn.variation == 'Full') {
//       // Assuming Full is double the price of Half
//       variationPrice = basePrice * 2;
//     }
    
//     int plateTotal = platePrice * addOn.plateitems;
//     return (variationPrice + plateTotal) * quantity;
//   }
// }

// class CartAddOn {
//   final String variation;
//   final int plateitems;

//   CartAddOn({
//     required this.variation,
//     required this.plateitems,
//   });

//   factory CartAddOn.fromJson(Map<String, dynamic> json) {
//     return CartAddOn(
//       variation: json['variation'] ?? '',
//       plateitems: json['plateitems'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'variation': variation,
//       'plateitems': plateitems,
//     };
//   }
// }

// class AppliedCoupon {
//   final String id;
//   final String code;
//   final int discountPercentage;
//   final int maxDiscountAmount;
//   final int minCartAmount;
//   final DateTime expiresAt;

//   AppliedCoupon({
//     required this.id,
//     required this.code,
//     required this.discountPercentage,
//     required this.maxDiscountAmount,
//     required this.minCartAmount,
//     required this.expiresAt,
//   });

//   factory AppliedCoupon.fromJson(Map<String, dynamic> json) {
//     return AppliedCoupon(
//       id: json['_id'] ?? '',
//       code: json['code'] ?? '',
//       discountPercentage: json['discountPercentage'] ?? 0,
//       maxDiscountAmount: json['maxDiscountAmount'] ?? 0,
//       minCartAmount: json['minCartAmount'] ?? 0,
//       expiresAt: DateTime.parse(json['expiresAt'] ?? DateTime.now().toIso8601String()),
//     );
//   }
// }

// class CartResponse {
//   final bool success;
//   final String message;
//   final double distanceKm;
//   final CartModel? cart;
//   final AppliedCoupon? appliedCoupon;

//   CartResponse({
//     required this.success,
//     this.message = '',
//     this.distanceKm = 0.0,
//     this.cart,
//     this.appliedCoupon,
//   });

//   factory CartResponse.fromJson(Map<String, dynamic> json) {
//     return CartResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       distanceKm: (json['distanceKm'] ?? 0).toDouble(),
//       cart: json['cart'] != null ? CartModel.fromJson(json['cart']) : null,
//       appliedCoupon: json['appliedCoupon'] != null
//           ? AppliedCoupon.fromJson(json['appliedCoupon'])
//           : null,
//     );
//   }
// }

// // Request models for API calls
// class AddToCartRequest {
//   final bool clearExisting;
//   final List<CartProductRequest> products;
//   final String? couponId;

//   AddToCartRequest({
//     required this.clearExisting,
//     required this.products,
//     this.couponId,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'clearExisting': clearExisting,
//       'products': products.map((p) => p.toJson()).toList(),
//       if (couponId != null) 'couponId': couponId,
//     };
//   }
// }

// class CartProductRequest {
//   final String restaurantProductId;
//   final String recommendedId;
//   final int quantity;
//   final CartAddOnRequest addOn;

//   CartProductRequest({
//     required this.restaurantProductId,
//     required this.recommendedId,
//     required this.quantity,
//     required this.addOn,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'restaurantProductId': restaurantProductId,
//       'recommendedId': recommendedId,
//       'quantity': quantity,
//       'addOn': addOn.toJson(),
//     };
//   }
// }

// class CartAddOnRequest {
//   final String variation;
//   final int plateitems;

//   CartAddOnRequest({
//     required this.variation,
//     required this.plateitems,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'variation': variation,
//       'plateitems': plateitems,
//     };
//   }
// }















// models/cart_model.dart
class CartModel {
  final String id;
  final String userId;
  final List<CartProduct> products;
  final int subTotal;
  final int deliveryCharge;
  final int couponDiscount;
  final int finalAmount;
  final int totalItems;
  final String? appliedCouponId;
  final DateTime createdAt;
  final String restaurantId;

  CartModel({
    required this.id,
    required this.userId,
    required this.products,
    required this.subTotal,
    required this.deliveryCharge,
    required this.couponDiscount,
    required this.finalAmount,
    required this.totalItems,
    this.appliedCouponId,
    required this.createdAt,
    required this.restaurantId,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    String userIdValue = '';
    if (json['userId'] is String) {
      userIdValue = json['userId'];
    } else if (json['userId'] is Map<String, dynamic>) {
      userIdValue = json['userId']['_id'] ?? json['userId']['id'] ?? '';
    }

    return CartModel(
      id: json['_id'] ?? '',
      userId: userIdValue,
      products: (json['products'] as List?)
              ?.map((item) => CartProduct.fromJson(item))
              .toList() ??
          [],
      subTotal: json['subTotal'] ?? 0,
      deliveryCharge: json['deliveryCharge'] ?? 0,
      couponDiscount: json['couponDiscount'] ?? 0,
      finalAmount: json['finalAmount'] ?? 0,
      totalItems: json['totalItems'] ?? 0,
      appliedCouponId: json['appliedCouponId'],
      createdAt: DateTime.parse(
          json['createdAt'] ?? DateTime.now().toIso8601String()),
      restaurantId: json['restaurantId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'products': products.map((item) => item.toJson()).toList(),
      'subTotal': subTotal,
      'deliveryCharge': deliveryCharge,
      'couponDiscount': couponDiscount,
      'finalAmount': finalAmount,
      'totalItems': totalItems,
      'appliedCouponId': appliedCouponId,
      'createdAt': createdAt.toIso8601String(),
      'restaurantId': restaurantId,
    };
  }
}

class CartProduct {
  final String id;
  final String restaurantProductId;
  final String recommendedId;
  final int quantity;
  final CartAddOn addOn;
  final String name;
  final int basePrice;
  final int platePrice;
  final String image;

  CartProduct({
    required this.id,
    required this.restaurantProductId,
    required this.recommendedId,
    required this.quantity,
    required this.addOn,
    required this.name,
    required this.basePrice,
    required this.platePrice,
    required this.image,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    String restaurantProductIdValue = '';
    if (json['restaurantProductId'] is String) {
      restaurantProductIdValue = json['restaurantProductId'];
    } else if (json['restaurantProductId'] is Map<String, dynamic>) {
      restaurantProductIdValue = json['restaurantProductId']['_id'] ??
          json['restaurantProductId']['id'] ??
          '';
    }

    return CartProduct(
      id: json['_id'] ?? '',
      restaurantProductId: restaurantProductIdValue,
      recommendedId: json['recommendedId'] ?? '',
      quantity: json['quantity'] ?? 1,
      addOn: CartAddOn.fromJson(json['addOn'] ?? {}),
      name: json['name'] ?? '',
      basePrice: json['basePrice'] ?? 0,
      platePrice: json['platePrice'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'restaurantProductId': restaurantProductId,
      'recommendedId': recommendedId,
      'quantity': quantity,
      'addOn': addOn.toJson(),
      'name': name,
      'basePrice': basePrice,
      'platePrice': platePrice,
      'image': image,
    };
  }

  int get totalPrice {
    int variationPrice = basePrice;
    if (addOn.variation == 'Full') {
      variationPrice = basePrice * 2;
    }

    int plateTotal = platePrice * addOn.plateitems;
    return (variationPrice + plateTotal) * quantity;
  }
}

class CartAddOn {
  final String variation;
  final int plateitems;

  CartAddOn({
    required this.variation,
    required this.plateitems,
  });

  factory CartAddOn.fromJson(Map<String, dynamic> json) {
    return CartAddOn(
      variation: json['variation'] ?? '',
      plateitems: json['plateitems'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'variation': variation,
      'plateitems': plateitems,
    };
  }
}

class AppliedCoupon {
  final String id;
  final String code;
  final int discountPercentage;
  final int maxDiscountAmount;
  final int minCartAmount;
  final DateTime expiresAt;

  AppliedCoupon({
    required this.id,
    required this.code,
    required this.discountPercentage,
    required this.maxDiscountAmount,
    required this.minCartAmount,
    required this.expiresAt,
  });

  factory AppliedCoupon.fromJson(Map<String, dynamic> json) {
    return AppliedCoupon(
      id: json['_id'] ?? '',
      code: json['code'] ?? '',
      discountPercentage: json['discountPercentage'] ?? 0,
      maxDiscountAmount: json['maxDiscountAmount'] ?? 0,
      minCartAmount: json['minCartAmount'] ?? 0,
      expiresAt: DateTime.parse(
          json['expiresAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class CartResponse {
  final bool success;
  final String message;
  final double distanceKm;
  final CartModel? cart;
  final AppliedCoupon? appliedCoupon;
  final int couponDiscount;

  CartResponse({
    required this.success,
    this.message = '',
    this.distanceKm = 0.0,
    this.cart,
    this.appliedCoupon,
    this.couponDiscount = 0,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      distanceKm: (json['distanceKm'] ?? 0).toDouble(),
      cart: json['cart'] != null ? CartModel.fromJson(json['cart']) : null,
      appliedCoupon: json['appliedCoupon'] != null
          ? AppliedCoupon.fromJson(json['appliedCoupon'])
          : null,
      couponDiscount: json['couponDiscount'] ?? 0,
    );
  }
}

// Request models
class AddToCartRequest {
  final List<CartProductRequest> products;
  final String? couponId;

  AddToCartRequest({
    required this.products,
    this.couponId,
  });

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((p) => p.toJson()).toList(),
      if (couponId != null) 'couponId': couponId,
    };
  }
}

class CartProductRequest {
  final String restaurantProductId;
  final String recommendedId;
  final int quantity;
  final CartAddOnRequest addOn;

  CartProductRequest({
    required this.restaurantProductId,
    required this.recommendedId,
    required this.quantity,
    required this.addOn,
  });

  Map<String, dynamic> toJson() {
    return {
      'restaurantProductId': restaurantProductId,
      'recommendedId': recommendedId,
      'quantity': quantity,
      'addOn': addOn.toJson(),
    };
  }
}

class CartAddOnRequest {
  final String variation;
  final int plateitems;

  CartAddOnRequest({
    required this.variation,
    required this.plateitems,
  });

  Map<String, dynamic> toJson() {
    return {
      'variation': variation,
      'plateitems': plateitems,
    };
  }
}

class UpdateQuantityRequest {
  final String restaurantProductId;
  final String recommendedId;
  final String action; // "inc" or "dec"

  UpdateQuantityRequest({
    required this.restaurantProductId,
    required this.recommendedId,
    required this.action,
  });

  Map<String, dynamic> toJson() {
    return {
      'restaurantProductId': restaurantProductId,
      'recommendedId': recommendedId,
      'action': action,
    };
  }
}