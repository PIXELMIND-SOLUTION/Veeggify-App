
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:veegify/views/home/recommended_screen.dart';

class CategoryBasedScreen extends StatefulWidget {
  final String categoryId;
  final String title;

   CategoryBasedScreen({super.key, required this.categoryId, required this.title});

  @override
  State<CategoryBasedScreen> createState() => _CategoryBasedScreenState();
}

class _CategoryBasedScreenState extends State<CategoryBasedScreen> {
  List<Map<String, dynamic>> restaurants = [];
  bool isLoading = true;
  String errorMessage = '';
  String categoryName = 'Category'; // Default name, will be updated from API

  @override
  void initState() {
    super.initState();
    fetchRestaurantsByCategory();
  }

  Future<void> fetchRestaurantsByCategory() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://vegifyy-backend-2.onrender.com/api/byCategorie/${widget.categoryId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          setState(() {
            restaurants = List<Map<String, dynamic>>.from(data['data']);
            // Update category name if available (you might need to adjust this based on your API)
            if (restaurants.isNotEmpty) {
              categoryName = restaurants[0]['categorie'] ?? 'Category';
            }
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = data['message'] ?? 'Failed to load data';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load data: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: SizedBox(
                height: 48,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (errorMessage.isNotEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(errorMessage),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: fetchRestaurantsByCategory,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              )
            else ...[

              const SizedBox(height: 8),

              // List of Restaurants
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailScreen(
                            restaurantId:
                                restaurant['id'] ?? "688787e3a2cb93cc3b9d4af4",
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color.fromARGB(255, 196, 196, 196)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            // Restaurant Image with Heart Icon
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      12), // Fixed border radius for all corners
                                  child: Image.network(
                                    restaurant['image'] ??
                                        'https://res.cloudinary.com/dwmna13fi/image/upload/v1752579676/categories/zs5fbmetun8k3vpuxzms.jpg',
                                    height: 122,
                                    width: 122,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      height: 122,
                                      width: 122,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  top: 8,
                                  right: 8,
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.favorite_border),
                                  ),
                                ),
                              ],
                            ),
                            // Restaurant Info
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurant['name'] ??
                                          'Unknown Restaurant',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.green),
                                          child: const Icon(Icons.star,
                                              size: 16,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          (restaurant['rating'] ?? 0)
                                              .toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      restaurant['content'] ??
                                          restaurant['description'] ??
                                          'No description available',
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Colors.green, size: 16),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            (restaurant['locationName'] ??
                                                    restaurant['location'] ??
                                                    'Location not available')
                                                .toString()
                                                .replaceAll('[', '')
                                                .replaceAll(']', ''),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
