
// class RestaurantProductResponse {
//   final bool success;
//   final int totalRecommendedItems;
//   final List<RecommendedProduct> recommendedProducts;

//   RestaurantProductResponse({
//     required this.success,
//     required this.totalRecommendedItems,
//     required this.recommendedProducts,
//   });

//   factory RestaurantProductResponse.fromJson(Map<String, dynamic> json) {
//     return RestaurantProductResponse(
//       success: json['success'] ?? false,
//       totalRecommendedItems: json['totalRecommendedItems'] ?? 0,
//       recommendedProducts: (json['recommendedProducts'] as List<dynamic>?)
//               ?.map((item) => RecommendedProduct.fromJson(item))
//               .toList() ??
//           [],
//     );
//   }
// }

// class RecommendedProduct {
//   final String id; // Added product ID
//   final String productId;
//   final String restaurantName;
//   final String locationName;
//   final List<String> type;
//   final String status;
//   final double rating;
//   final int viewCount;
//   final RecommendedItem recommendedItem;

//   RecommendedProduct({
//     required this.id,
//     required this.productId,
//     required this.restaurantName,
//     required this.locationName,
//     required this.type,
//     required this.status,
//     required this.rating,
//     required this.viewCount,
//     required this.recommendedItem,
//   });

//   factory RecommendedProduct.fromJson(Map<String, dynamic> json) {
//     return RecommendedProduct(
//       id: json['_id'] ?? json['id'] ?? '', // Handle both _id and id fields
//       productId: json['productId'] ?? '',
//       restaurantName: json['restaurantName'] ?? '',
//       locationName: json['locationName'] ?? '',
//       type: List<String>.from(json['type'] ?? []),
//       status: json['status'] ?? '',
//       rating: (json['rating'] ?? 0).toDouble(),
//       viewCount: json['viewCount'] ?? 0,
//       recommendedItem: RecommendedItem.fromJson(json['recommendedItem'] ?? {}),
//     );
//   }
// }

// class RecommendedItem {
//   final String itemId;
//   final String name;
//   final int price;
//   final double rating;
//   final int viewCount;
//   final String content;
//   final String image;
//   final Addons addons;
//   final Category category;
//   final int vendorHalfPercentage;
//   final int vendorPlateCost;

//   RecommendedItem({
//     required this.itemId,
//     required this.name,
//     required this.price,
//     required this.rating,
//     required this.viewCount,
//     required this.content,
//     required this.image,
//     required this.addons,
//     required this.category,
//     required this.vendorHalfPercentage,
//     required this.vendorPlateCost,
//   });

//   factory RecommendedItem.fromJson(Map<String, dynamic> json) {
//     return RecommendedItem(
//       itemId: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       price: json['price'] ?? 0,
//       rating: (json['rating'] ?? 0).toDouble(),
//       viewCount: json['viewCount'] ?? 0,
//       content: json['content'] ?? '',
//       image: json['image'] ?? '',
//       addons: Addons.fromJson(json['addons'] ?? {}),
//       category: Category.fromJson(json['category'] ?? {}),
//       vendorHalfPercentage: json['vendorHalfPercentage'] ?? 0,
//       vendorPlateCost: json['vendor_Platecost'] ?? 0,
//     );
//   }
// }

// class Addons {
//   final Variation variation;
//   final Plates plates;
//   final String productName;

//   Addons({
//     required this.variation,
//     required this.plates,
//     required this.productName,
//   });

//   factory Addons.fromJson(Map<String, dynamic> json) {
//     return Addons(
//       variation: Variation.fromJson(json['variation'] ?? {}),
//       plates: Plates.fromJson(json['plates'] ?? {}),
//       productName: json['productName'] ?? '',
//     );
//   }
// }

// class Variation {
//   final String name;
//   final List<String> type;

//   Variation({
//     required this.name,
//     required this.type,
//   });

//   factory Variation.fromJson(Map<String, dynamic> json) {
//     return Variation(
//       name: json['name'] ?? '',
//       type: List<String>.from(json['type'] ?? []),
//     );
//   }
// }

// class Plates {
//   final String name;

//   Plates({
//     required this.name,
//   });

//   factory Plates.fromJson(Map<String, dynamic> json) {
//     return Plates(
//       name: json['name'] ?? '',
//     );
//   }
// }

// class Category {
//   final String id;
//   final String categoryName;
//   final String imageUrl;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   Category({
//     required this.id,
//     required this.categoryName,
//     required this.imageUrl,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['_id'] ?? '',
//       categoryName: json['categoryName'] ?? '',
//       imageUrl: json['imageUrl'] ?? '',
//       createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
//       updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
//       v: json['__v'] ?? 0,
//     );
//   }
// }

// // Keep the existing CartItem class for cart functionality
// class CartItem {
//   final String id;
//   final String title;
//   final String image;
//   final num basePrice;
//   final String variation;
//   final Set<String> addOns;
//   final int quantity;
//   final bool isVeg;

//   CartItem({
//     required this.id,
//     required this.title,
//     required this.image,
//     required this.basePrice,
//     required this.variation,
//     required this.addOns,
//     required this.quantity,
//     required this.isVeg,
//   });

//   num get totalPrice {
//     num addOnPrice = 0;
//     if (addOns.contains('1 Plate')) addOnPrice += 5;
//     if (addOns.contains('2 Plates')) addOnPrice += 10;
    
//     num variationMultiplier = variation == 'Full' ? 1.5 : 1.0;
//     return (basePrice * variationMultiplier + addOnPrice) * quantity;
//   }
// }

// // Helper class to associate product ID with recommended item
// class RecommendedItemWithId {
//   final String productId;
//   final RecommendedItem recommendedItem;

//   RecommendedItemWithId({
//     required this.productId,
//     required this.recommendedItem,
//   });
// }










class RestaurantProductResponse {
  final bool success;
  final int totalRecommendedItems;
  final List<RecommendedProduct> recommendedProducts;

  RestaurantProductResponse({
    this.success = false,
    this.totalRecommendedItems = 0,
    this.recommendedProducts = const [],
  });

  factory RestaurantProductResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return RestaurantProductResponse();
    return RestaurantProductResponse(
      success: json['success'] ?? false,
      totalRecommendedItems: json['totalRecommendedItems'] ?? 0,
      recommendedProducts: (json['recommendedProducts'] as List?)
              ?.map((item) => RecommendedProduct.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class RecommendedProduct {
  final String id;
  final String productId;
  final String restaurantName;
  final String locationName;
  final List<String> type;
  final String status;
  final double rating;
  final int viewCount;
  final RecommendedItem recommendedItem;

  RecommendedProduct({
    this.id = '',
    this.productId = '',
    this.restaurantName = '',
    this.locationName = '',
    this.type = const [],
    this.status = '',
    this.rating = 0.0,
    this.viewCount = 0,
    RecommendedItem? recommendedItem,
  }) : recommendedItem = recommendedItem ?? RecommendedItem();

  factory RecommendedProduct.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) return RecommendedProduct();
    return RecommendedProduct(
      id: json['_id'] ?? json['id'] ?? '',
      productId: json['productId'] ?? '',
      restaurantName: json['restaurantName'] ?? '',
      locationName: json['locationName'] ?? '',
      type: (json['type'] is List)
          ? List<String>.from(json['type'])
          : const [],
      status: json['status'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      viewCount: json['viewCount'] ?? 0,
      recommendedItem: RecommendedItem.fromJson(json['recommendedItem']),
    );
  }
}

class RecommendedItem {
  final String itemId;
  final String name;
  final int price;
  final double rating;
  final int viewCount;
  final String content;
  final String image;
  final Addons addons;
  final Category category;
  final int vendorHalfPercentage;
  final int vendorPlateCost;

  RecommendedItem({
    this.itemId = '',
    this.name = '',
    this.price = 0,
    this.rating = 0.0,
    this.viewCount = 0,
    this.content = '',
    this.image = '',
    Addons? addons,
    Category? category,
    this.vendorHalfPercentage = 0,
    this.vendorPlateCost = 0,
  })  : addons = addons ?? Addons(),
        category = category ?? Category();

  factory RecommendedItem.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) return RecommendedItem();
    return RecommendedItem(
      itemId: json['_id'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      viewCount: json['viewCount'] ?? 0,
      content: json['content'] ?? '',
      image: json['image'] ?? '',
      addons: Addons.fromJson(json['addons']),
      category: Category.fromJson(json['category']),
      vendorHalfPercentage: json['vendorHalfPercentage'] ?? 0,
      vendorPlateCost: json['vendor_Platecost'] ?? 0,
    );
  }
}

class Addons {
  final Variation variation;
  final Plates plates;
  final String productName;

  Addons({
    Variation? variation,
    Plates? plates,
    this.productName = '',
  })  : variation = variation ?? Variation(),
        plates = plates ?? Plates();

  factory Addons.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) return Addons();
    return Addons(
      variation: Variation.fromJson(json['variation']),
      plates: Plates.fromJson(json['plates']),
      productName: json['productName'] ?? '',
    );
  }
}

class Variation {
  final String name;
  final List<String> type;

  Variation({
    this.name = '',
    this.type = const [],
  });

  factory Variation.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) return Variation();
    return Variation(
      name: json['name'] ?? '',
      type: (json['type'] is List)
          ? List<String>.from(json['type'])
          : const [],
    );
  }
}

class Plates {
  final String name;

  Plates({this.name = ''});

  factory Plates.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) return Plates();
    return Plates(
      name: json['name'] ?? '',
    );
  }
}

class Category {
  final String id;
  final String categoryName;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Category({
    this.id = '',
    this.categoryName = '',
    this.imageUrl = '',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.v = 0,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Category.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) return Category();
    return Category(
      id: json['_id'] ?? '',
      categoryName: json['categoryName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      v: json['__v'] ?? 0,
    );
  }
}

class CartItem {
  final String id;
  final String title;
  final String image;
  final num basePrice;
  final String variation;
  final Set<String> addOns;
  final int quantity;
  final bool isVeg;

  CartItem({
    this.id = '',
    this.title = '',
    this.image = '',
    this.basePrice = 0,
    this.variation = '',
    this.addOns = const {},
    this.quantity = 1,
    this.isVeg = true,
  });

  num get totalPrice {
    num addOnPrice = 0;
    if (addOns.contains('1 Plate')) addOnPrice += 5;
    if (addOns.contains('2 Plates')) addOnPrice += 10;

    num variationMultiplier = variation == 'Full' ? 1.5 : 1.0;
    return (basePrice * variationMultiplier + addOnPrice) * quantity;
  }
}

class RecommendedItemWithId {
  final String productId;
  final RecommendedItem recommendedItem;

  RecommendedItemWithId({
    this.productId = '',
    RecommendedItem? recommendedItem,
  }) : recommendedItem = recommendedItem ?? RecommendedItem();
}
