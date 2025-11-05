// wishlist_product.dart
import 'dart:convert';

class WishlistProduct {
  final String id;
  final String name;
  final int price; // integer price (rupees)
  final String category;
  final int stock;
  final String description;
  final String image; // first image URL (empty string if none)
  final List<String> images; // all image URLs (maybe empty)
  final String variation;
  final String restaurantId;
  final String restaurantName;
  final DateTime? createdAt;
  final dynamic rating; // e.g., 4.2
  final dynamic viewcount;

  WishlistProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.stock,
    required this.description,
    required this.image,
    required this.images,
    required this.variation,
    required this.restaurantId,
    required this.restaurantName,
    required this.createdAt,
    required this.rating,
    required this.viewcount,
  });

  // --- Helper converters (defensive) ---
  static String _safeString(dynamic v, [String fallback = '']) {
    if (v == null) return fallback;
    if (v is String) return v.trim();
    if (v is num) return v.toString();
    try {
      return v.toString();
    } catch (_) {
      return fallback;
    }
  }

  static int _safeInt(dynamic v, [int fallback = 0]) {
    if (v == null) return fallback;
    if (v is int) return v;
    if (v is double) return v.toInt();
    final s = _safeString(v);
    if (s.isEmpty) return fallback;
    // remove non-digit except minus
    final cleaned = s.replaceAll(RegExp(r'[^0-9\-]'), '');
    if (cleaned.isEmpty) return fallback;
    return int.tryParse(cleaned) ?? fallback;
  }

  static double _safeDouble(dynamic v, [double fallback = 0.0]) {
    if (v == null) return fallback;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    final s = _safeString(v);
    if (s.isEmpty) return fallback;
    final cleaned = s.replaceAll(RegExp(r'[^0-9\.\-]'), '');
    if (cleaned.isEmpty) return fallback;
    return double.tryParse(cleaned) ?? fallback;
  }

  // Try to extract a list of strings from various shapes
  static List<String> _extractImages(dynamic imgField) {
    if (imgField == null) return <String>[];
    if (imgField is String) {
      // sometimes API returns a JSON string of list
      final s = imgField.trim();
      if (s.isEmpty) return <String>[];
      // quick heuristic: if looks like JSON array, try decode
      if ((s.startsWith('[') && s.endsWith(']')) || s.contains('http')) {
        try {
          final decoded = jsonDecode(s);
          if (decoded is List) {
            return decoded.whereType<dynamic>().map((e) => _safeString(e)).where((e) => e.isNotEmpty).toList();
          }
        } catch (_) {
          // not JSON array, treat as single image string
        }
      }
      // treat as single image URL
      return [s];
    }
    if (imgField is List) {
      final out = <String>[];
      for (final it in imgField) {
        final s = _safeString(it);
        if (s.isNotEmpty) out.add(s);
      }
      return out;
    }
    if (imgField is Map) {
      // common keys to try
      for (final k in ['url', 'image', 'src', 'path']) {
        if (imgField[k] != null) {
          final s = _safeString(imgField[k]);
          if (s.isNotEmpty) return [s];
        }
      }
      // fallback convert whole map to string if it looks like url
      final asString = _safeString(imgField.toString());
      if (asString.contains('http')) return [asString];
    }
    try {
      final s = _safeString(imgField);
      return s.isEmpty ? <String>[] : [s];
    } catch (_) {
      return <String>[];
    }
  }

  // --- Factory ---
  factory WishlistProduct.fromJson(Map<String, dynamic> json) {
    // Id
    final id = _safeString(json['_id'] ?? json['id'] ?? '');

    // Name (prefer productName -> addons.productName -> name -> title)
    String name = '';
    if (json.containsKey('productName')) {
      name = _safeString(json['productName']);
    } else if (json['addons'] != null && json['addons'] is Map && (json['addons']['productName'] != null)) {
      name = _safeString(json['addons']['productName']);
    } else if (json.containsKey('name')) {
      name = _safeString(json['name']);
    } else if (json.containsKey('title')) {
      name = _safeString(json['title']);
    }

    // Price (productPrice / price / vendor_Price)
    int price = _safeInt(json['productPrice'] ?? json['price'] ?? json['vendor_Price'] ?? 0);

    // Category (contentname / category)
    final category = _safeString(json['contentname'] ?? json['category'] ?? '');

    // Stock
    int stock = 10; // default assume available
    if (json.containsKey('stock')) {
      stock = _safeInt(json['stock'], 0);
    } else if (json.containsKey('quantity')) {
      stock = _safeInt(json['quantity'], 0);
    }

    // Description
    final description = _safeString(json['description'] ?? json['desc'] ?? '');

    // Images
    final images = _extractImages(json['image']);
    final firstImage = images.isNotEmpty ? images.first : '';

    // Variation: try addons.variation
    String variation = '';
    try {
      final addons = json['addons'];
      if (addons != null && addons is Map && addons['variation'] != null) {
        final varField = addons['variation'];
        if (varField is Map) {
          if (varField['name'] != null) variation = _safeString(varField['name']);
          else if (varField['type'] != null) {
            final t = varField['type'];
            if (t is List && t.isNotEmpty) variation = _safeString(t.first);
            else variation = _safeString(t);
          } else {
            variation = _safeString(varField);
          }
        } else {
          variation = _safeString(varField);
        }
      } else {
        variation = _safeString(json['variation'] ?? '');
      }
    } catch (_) {
      variation = _safeString(json['variation'] ?? '');
    }

    // restaurant info
    final restaurantId = _safeString(json['restaurantId'] ?? json['vendorId'] ?? '');
    final restaurantName = _safeString(json['restaurantName'] ?? json['vendorName'] ?? '');

    // createdAt
    DateTime? createdAt;
    final rawCreated = json['createdAt'] ?? json['created_at'] ?? json['date'];
    if (rawCreated != null) {
      final s = _safeString(rawCreated);
      createdAt = DateTime.tryParse(s);
    }

    // rating & viewcount
    final rating = _safeDouble(json['rating'] ?? json['ratings'] ?? json['avgRating'] ?? 0.0);
    final viewcount = _safeInt(json['viewcount'] ?? json['views'] ?? json['viewCount'] ?? 0);

    return WishlistProduct(
      id: id,
      name: name.isNotEmpty ? name : 'Unnamed product',
      price: price,
      category: category,
      stock: stock,
      description: description,
      image: firstImage,
      images: images,
      variation: variation,
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      createdAt: createdAt,
      rating: rating,
      viewcount: viewcount,
    );
  }

  // --- toJson (serialize) ---
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productName': name,
      'productPrice': price,
      'category': category,
      'stock': stock,
      'description': description,
      'image': images, // keep as list to preserve original shape
      'variation': variation,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'createdAt': createdAt?.toIso8601String(),
      'rating': rating,
      'viewcount': viewcount,
    };
  }

  // --- Helper: parse response (Map with 'wishlist' or list) ---
  static List<WishlistProduct> parseWishlistResponse(dynamic response) {
    final List<WishlistProduct> out = [];
    if (response == null) return out;

    try {
      if (response is Map<String, dynamic> && response.containsKey('wishlist')) {
        final list = response['wishlist'];
        if (list is List) {
          for (final item in list) {
            if (item is Map<String, dynamic>) {
              out.add(WishlistProduct.fromJson(item));
            } else {
              // try to coerce
              out.add(WishlistProduct.fromJson(Map<String, dynamic>.from(item)));
            }
          }
        }
      } else if (response is List) {
        for (final item in response) {
          if (item is Map<String, dynamic>) {
            out.add(WishlistProduct.fromJson(item));
          } else {
            out.add(WishlistProduct.fromJson(Map<String, dynamic>.from(item)));
          }
        }
      } else if (response is String) {
        // possibly a raw JSON string
        try {
          final decoded = jsonDecode(response);
          return parseWishlistResponse(decoded);
        } catch (_) {
          // ignore
        }
      }
    } catch (_) {
      // ignore parsing errors - return whatever collected
    }

    return out;
  }

  @override
  String toString() {
    return 'WishlistProduct(id: $id, name: $name, price: $price, image: $image, rating: $rating, viewcount: $viewcount)';
  }
}
