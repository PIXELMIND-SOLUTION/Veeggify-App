import 'package:veegify/model/product_model.dart';

class AddOn {
  final String id;
  final String name;
  final double price;

  AddOn({
    required this.id,
    required this.name,
    required this.price,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) {
    return AddOn(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
    };
  }
}



class WishlistResponse {
  final String message;
  final bool? isInWishlist;
  final List<String>? wishlistIds;
  final List<Product>? wishlist;

  WishlistResponse({
    required this.message,
    this.isInWishlist,
    this.wishlistIds,
    this.wishlist,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    return WishlistResponse(
      message: json['message'] ?? '',
      isInWishlist: json['isInWishlist'],
      wishlistIds: json['wishlist'] is List
    ? List<String>.from(
        json['wishlist'].map((item) => item['_id'].toString()))
    : null,

      wishlist: json['wishlist'] is List<dynamic> && 
                json['wishlist'].isNotEmpty && 
                json['wishlist'][0] is Map<String, dynamic>
          ? List<Product>.from(
              json['wishlist'].map((item) => Product.fromJson(item)))
          : null,
    );
  }
}
