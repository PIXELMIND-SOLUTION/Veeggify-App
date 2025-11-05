// lib/models/order.dart
import 'dart:convert';

class PointLocation {
  final String type;
  final List<double> coordinates;

  PointLocation({required this.type, required this.coordinates});

  factory PointLocation.fromJson(Map<String, dynamic> json) => PointLocation(
        type: json['type'] ?? 'Point',
        coordinates: (json['coordinates'] as List).map((e) => (e as num).toDouble()).toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };
}

class RestaurantSummary {
  final String id;
  final String restaurantName;
  final String locationName;

  RestaurantSummary({
    required this.id,
    required this.restaurantName,
    required this.locationName,
  });

  factory RestaurantSummary.fromJson(Map<String, dynamic> json) => RestaurantSummary(
        id: json['_id'] as String,
        restaurantName: json['restaurantName'] as String,
        locationName: json['locationName'] as String,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'restaurantName': restaurantName,
        'locationName': locationName,
      };
}

class DeliveryAddress {
  final String id;
  final String street;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final String addressType;

  DeliveryAddress({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.addressType,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) => DeliveryAddress(
        id: json['_id'] as String,
        street: json['street'] as String,
        city: json['city'] as String,
        state: json['state'] as String,
        country: json['country'] as String,
        postalCode: json['postalCode'] as String,
        addressType: json['addressType'] as String,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'street': street,
        'city': city,
        'state': state,
        'country': country,
        'postalCode': postalCode,
        'addressType': addressType,
      };
}

class OrderProduct {
  final String id;
  final String restaurantProductId;
  final String? recommendedId;
  final int quantity;
  final String name;
  final double basePrice;
  final String? image;

  OrderProduct({
    required this.id,
    required this.restaurantProductId,
    this.recommendedId,
    required this.quantity,
    required this.name,
    required this.basePrice,
    this.image,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        id: json['_id'] as String,
        restaurantProductId: json['restaurantProductId'] as String,
        recommendedId: json['recommendedId'] as String?,
        quantity: (json['quantity'] as num).toInt(),
        name: json['name'] as String,
        basePrice: (json['basePrice'] as num).toDouble(),
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'restaurantProductId': restaurantProductId,
        'recommendedId': recommendedId,
        'quantity': quantity,
        'name': name,
        'basePrice': basePrice,
        'image': image,
      };
}

class Order {
  final String id;
  final String userId;
  final String cartId;
  final RestaurantSummary restaurant;
  final DeliveryAddress deliveryAddress;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final String? deliveryBoyId;
  final String deliveryStatus;
  final List<OrderProduct> products;
  final int totalItems;
  final double subTotal;
  final double deliveryCharge;
  final double couponDiscount;
  final double totalPayable;
  final double distanceKm;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PointLocation restaurantLocation;
  final PointLocation deliveryLocation;

  Order({
    required this.id,
    required this.userId,
    required this.cartId,
    required this.restaurant,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    this.deliveryBoyId,
    required this.deliveryStatus,
    required this.products,
    required this.totalItems,
    required this.subTotal,
    required this.deliveryCharge,
    required this.couponDiscount,
    required this.totalPayable,
    required this.distanceKm,
    required this.createdAt,
    required this.updatedAt,
    required this.restaurantLocation,
    required this.deliveryLocation,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      cartId: json['cartId'] as String,
      restaurant: RestaurantSummary.fromJson(json['restaurantId'] as Map<String, dynamic>),
      deliveryAddress: DeliveryAddress.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
      paymentMethod: json['paymentMethod'] as String,
      paymentStatus: json['paymentStatus'] as String,
      orderStatus: json['orderStatus'] as String,
      deliveryBoyId: json['deliveryBoyId'] as String?,
      deliveryStatus: json['deliveryStatus'] as String,
      products: (json['products'] as List).map((p) => OrderProduct.fromJson(p as Map<String, dynamic>)).toList(),
      totalItems: (json['totalItems'] as num).toInt(),
      subTotal: (json['subTotal'] as num).toDouble(),
      deliveryCharge: (json['deliveryCharge'] as num).toDouble(),
      couponDiscount: (json['couponDiscount'] as num).toDouble(),
      totalPayable: (json['totalPayable'] as num).toDouble(),
      distanceKm: (json['distanceKm'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      restaurantLocation: PointLocation.fromJson(json['restaurantLocation'] as Map<String, dynamic>),
      deliveryLocation: PointLocation.fromJson(json['deliveryLocation'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': userId,
        'cartId': cartId,
        'restaurantId': restaurant.toJson(),
        'deliveryAddress': deliveryAddress.toJson(),
        'paymentMethod': paymentMethod,
        'paymentStatus': paymentStatus,
        'orderStatus': orderStatus,
        'deliveryBoyId': deliveryBoyId,
        'deliveryStatus': deliveryStatus,
        'products': products.map((p) => p.toJson()).toList(),
        'totalItems': totalItems,
        'subTotal': subTotal,
        'deliveryCharge': deliveryCharge,
        'couponDiscount': couponDiscount,
        'totalPayable': totalPayable,
        'distanceKm': distanceKm,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'restaurantLocation': restaurantLocation.toJson(),
        'deliveryLocation': deliveryLocation.toJson(),
      };
}

// helper to parse list JSON response like your API returns
List<Order> ordersFromApiResponse(String body) {
  final Map<String, dynamic> parsed = json.decode(body) as Map<String, dynamic>;

  if (parsed['success'] != true) return [];

  final List<dynamic> data = parsed['data'] as List<dynamic>;

  return data.map((e) => Order.fromJson(e as Map<String, dynamic>)).toList();
}
