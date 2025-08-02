class NearbyRestaurantModel {
  final String id;
  final String restaurantName;
  final String description;
  final String imageUrl;
  final int rating;
  final int startingPrice;

  NearbyRestaurantModel({
    required this.id,
    required this.restaurantName,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.startingPrice,
  });

  factory NearbyRestaurantModel.fromJson(Map<String, dynamic> json) {
    return NearbyRestaurantModel(
      id: json['_id'],
      restaurantName: json['restaurantName'],
      description: json['description'],
      imageUrl: json['image']['url'],
      rating: json['rating'],
      startingPrice: json['startingPrice'],
    );
  }
}
