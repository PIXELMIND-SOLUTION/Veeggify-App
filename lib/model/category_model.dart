class Category {
  final int id;
  final String categoryName;
  final String imageUrl;

  Category({
    required this.id,
    required this.categoryName,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['categoryName'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryName': categoryName,
      'imageUrl': imageUrl,
    };
  }
}
