// // models/restaurant_product_model.dart

// class RestaurantProductResponse {
//   final bool success;
//   final String message;
//   final List<RestaurantProduct> data;

//   RestaurantProductResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory RestaurantProductResponse.fromJson(Map<String, dynamic> json) {
//     return RestaurantProductResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       data: (json['data'] as List<dynamic>?)
//               ?.map((item) => RestaurantProduct.fromJson(item))
//               .toList() ??
//           [],
//     );
//   }
// }

// class RestaurantProduct {
//   final String id;
//   final String restaurantName;
//   final String locationName;
//   final List<String> type;
//   final double rating;
//   final int viewCount;
//   final int productPrice;
//   final int vendorHalfPercentage;
//   final int? vendorPlatecost;
//   final List<RecommendedItem> recommended;
//   final Addons addons;
//   final String user;
//   final String restaurantId;
//   final String status;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final TimeAndDistance timeAndKm;

//   RestaurantProduct({
//     required this.id,
//     required this.restaurantName,
//     required this.locationName,
//     required this.type,
//     required this.rating,
//     required this.viewCount,
//     required this.productPrice,
//     required this.vendorHalfPercentage,
//     this.vendorPlatecost,
//     required this.recommended,
//     required this.addons,
//     required this.user,
//     required this.restaurantId,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.timeAndKm,
//   });

//   factory RestaurantProduct.fromJson(Map<String, dynamic> json) {
//     return RestaurantProduct(
//       id: json['_id'] ?? '',
//       restaurantName: json['restaurantName'] ?? '',
//       locationName: json['locationName'] ?? '',
//       type: List<String>.from(json['type'] ?? []),
//       rating: (json['rating'] ?? 0).toDouble(),
//       viewCount: json['viewCount'] ?? 0,
//       productPrice: json['productPrice'] ?? 0,
//       vendorHalfPercentage: json['vendorHalfPercentage'] ?? 0,
//       vendorPlatecost: json['vendor_Platecost'],
//       recommended: (json['recommended'] as List<dynamic>?)
//               ?.map((item) => RecommendedItem.fromJson(item))
//               .toList() ??
//           [],
//       addons: Addons.fromJson(json['addons'] ?? {}),
//       user: json['user'] ?? '',
//       restaurantId: json['restaurantId'] ?? '',
//       status: json['status'] ?? '',
//       createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
//       updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
//       timeAndKm: TimeAndDistance.fromJson(json['timeAndKm'] ?? {}),
//     );
//   }
// }

// class RecommendedItem {
//   final String id;
//   final String image;
//   final String name;
//   final int price;
//   final double rating;
//   final int viewCount;
//   final String content;

//   RecommendedItem({
//     required this.id,
//     required this.image,
//     required this.name,
//     required this.price,
//     required this.rating,
//     required this.viewCount,
//     required this.content,
//   });

//   factory RecommendedItem.fromJson(Map<String, dynamic> json) {
//     return RecommendedItem(
//       id: json['_id'] ?? '',
//       image: json['image'] ?? '',
//       name: json['name'] ?? '',
//       price: json['price'] ?? 0,
//       rating: (json['rating'] ?? 0).toDouble(),
//       viewCount: json['viewCount'] ?? 0,
//       content: json['content'] ?? '',
//     );
//   }
// }

// class Addons {
//   final String productName;
//   final Variation variation;
//   final Plates plates;
//   final AddonImage addonImage;

//   Addons({
//     required this.productName,
//     required this.variation,
//     required this.plates,
//     required this.addonImage,
//   });

//   factory Addons.fromJson(Map<String, dynamic> json) {
//     return Addons(
//       productName: json['productName'] ?? '',
//       variation: Variation.fromJson(json['variation'] ?? {}),
//       plates: Plates.fromJson(json['plates'] ?? {}),
//       addonImage: AddonImage.fromJson(json['addonImage'] ?? {}),
//     );
//   }
// }

// class Variation {
//   final String name;
//   final String type;
//   final int? vendorPercentage;
//   final int price;

//   Variation({
//     required this.name,
//     required this.type,
//     this.vendorPercentage,
//     required this.price,
//   });

//   factory Variation.fromJson(Map<String, dynamic> json) {
//     return Variation(
//       name: json['name'] ?? '',
//       type: json['type'] ?? '',
//       vendorPercentage: json['vendorPercentage'],
//       price: json['price'] ?? 0,
//     );
//   }
// }

// class Plates {
//   final String name;
//   final int item;
//   final int? platePrice;
//   final int? totalPlatesPrice;

//   Plates({
//     required this.name,
//     required this.item,
//     this.platePrice,
//     this.totalPlatesPrice,
//   });

//   factory Plates.fromJson(Map<String, dynamic> json) {
//     return Plates(
//       name: json['name'] ?? '',
//       item: json['item'] ?? 0,
//       platePrice: json['platePrice'] ?? json['platepeice'],
//       totalPlatesPrice: json['totalPlatesPrice'],
//     );
//   }
// }

// class AddonImage {
//   final String publicId;
//   final String url;

//   AddonImage({
//     required this.publicId,
//     required this.url,
//   });

//   factory AddonImage.fromJson(Map<String, dynamic> json) {
//     return AddonImage(
//       publicId: json['public_id'] ?? '',
//       url: json['url'] ?? '',
//     );
//   }
// }

// class TimeAndDistance {
//   final String time;
//   final String distance;

//   TimeAndDistance({
//     required this.time,
//     required this.distance,
//   });

//   factory TimeAndDistance.fromJson(Map<String, dynamic> json) {
//     return TimeAndDistance(
//       time: json['time'] ?? '',
//       distance: json['distance'] ?? '',
//     );
//   }
// }









class RestaurantProductResponse {
  final bool success;
  final String message;
  final List<RestaurantProduct> data;

  RestaurantProductResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RestaurantProductResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantProductResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => RestaurantProduct.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class RestaurantProduct {
  final TimeAndDistance timeAndKm;
  final String id;
  final String restaurantName;
  final String locationName;
  final List<String> type;
  final double rating;
  final int viewCount;
  final int productPrice;
  final int vendorHalfPercentage;
  final List<RecommendedItem> recommended;
  final Addons addons;
  final String user;
  final String restaurantId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final double? vendorPlatecost;

  RestaurantProduct({
    required this.timeAndKm,
    required this.id,
    required this.restaurantName,
    required this.locationName,
    required this.type,
    required this.rating,
    required this.viewCount,
    required this.productPrice,
    required this.vendorHalfPercentage,
    required this.recommended,
    required this.addons,
    required this.user,
    required this.restaurantId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.vendorPlatecost,
  });

  factory RestaurantProduct.fromJson(Map<String, dynamic> json) {
    return RestaurantProduct(
      timeAndKm: TimeAndDistance.fromJson(json['timeAndKm'] ?? {}),
      id: json['_id'] ?? '',
      restaurantName: json['restaurantName'] ?? '',
      locationName: json['locationName'] ?? '',
      type: List<String>.from(json['type'] ?? []),
      rating: (json['rating'] ?? 0).toDouble(),
      viewCount: json['viewCount'] ?? 0,
      productPrice: json['productPrice'] ?? 0,
      vendorHalfPercentage: json['vendorHalfPercentage'] ?? 0,
      recommended: (json['recommended'] as List<dynamic>?)
              ?.map((item) => RecommendedItem.fromJson(item))
              .toList() ??
          [],
      addons: Addons.fromJson(json['addons'] ?? {}),
      user: json['user'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      v: json['__v'] ?? 0,
      vendorPlatecost: json['vendor_Platecost']?.toDouble(),
    );
  }
}

class RecommendedItem {
  final String image;
  final String name;
  final int price;
  final double rating;
  final int viewCount;
  final String content;
  final String id;

  RecommendedItem({
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
    required this.viewCount,
    required this.content,
    required this.id,
  });

  factory RecommendedItem.fromJson(Map<String, dynamic> json) {
    return RecommendedItem(
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      viewCount: json['viewCount'] ?? 0,
      content: json['content'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}

class Addons {
  final String productName;
  final Variation variation;
  final Plates plates;
  final AddonImage addonImage;

  Addons({
    required this.productName,
    required this.variation,
    required this.plates,
    required this.addonImage,
  });

  factory Addons.fromJson(Map<String, dynamic> json) {
    return Addons(
      productName: json['productName'] ?? '',
      variation: Variation.fromJson(json['variation'] ?? {}),
      plates: Plates.fromJson(json['plates'] ?? {}),
      addonImage: AddonImage.fromJson(json['addonImage'] ?? {}),
    );
  }
}

class Variation {
  final String name;
  final String type;
  final int? vendorPercentage;
  final double price;

  Variation({
    required this.name,
    required this.type,
    this.vendorPercentage,
    required this.price,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      vendorPercentage: json['vendorPercentage'],
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}

class Plates {
  final String name;
  final int item;
  final double? platePrice;
  final double? totalPlatesPrice;

  Plates({
    required this.name,
    required this.item,
    this.platePrice,
    this.totalPlatesPrice,
  });

  factory Plates.fromJson(Map<String, dynamic> json) {
    return Plates(
      name: json['name'] ?? '',
      item: json['item'] ?? 0,
      platePrice: json['platePrice']?.toDouble(),
      totalPlatesPrice: json['totalPlatesPrice']?.toDouble(),
    );
  }
}

class AddonImage {
  final String publicId;
  final String url;

  AddonImage({
    required this.publicId,
    required this.url,
  });

  factory AddonImage.fromJson(Map<String, dynamic> json) {
    return AddonImage(
      publicId: json['public_id'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class TimeAndDistance {
  final String time;
  final String distance;

  TimeAndDistance({
    required this.time,
    required this.distance,
  });

  factory TimeAndDistance.fromJson(Map<String, dynamic> json) {
    return TimeAndDistance(
      time: json['time'] ?? '',
      distance: json['distance'] ?? '',
    );
  }
}