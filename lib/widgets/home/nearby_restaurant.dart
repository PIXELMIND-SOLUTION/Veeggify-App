import 'package:flutter/material.dart';
import 'package:veegify/views/home/recommended_screen.dart';

// --- RestaurantCard Widget ---
class RestaurantCard extends StatelessWidget {
  final String id;
  final String imagePath;
  final String name;
  final double rating;
  final String description;
  final int price;

  const RestaurantCard({
    super.key,
    required this.id,
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantDetailScreen(restaurantId: id))),
      child: Container(
        margin: EdgeInsets.only(right: 12),
        width: 186,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container with Stack
            Container(
              height: 186,
              child: Stack(
                children: [
                  // Image Container with Direct Shadow
                  Container(
                    height: 186,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.3),
                      //     spreadRadius: 2,
                      //     blurRadius: 8,
                      //     offset: const Offset(0, 4),
                      //   ),
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.1),
                      //     spreadRadius: 5,
                      //     blurRadius: 15,
                      //     offset: const Offset(0, 8),
                      //   ),
                      // ],
                      image: DecorationImage(
                        image: NetworkImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
      
                  // Favorite Icon - Top Right
                  // Positioned(
                  //   top: 8,
                  //   right: 8,
                  //   child: Container(
                  //     width: 40,
                  //     height: 40,
                  //     padding: const EdgeInsets.all(4),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(25),
                  //     ),
                  //     child: const Icon(
                  //       Icons.favorite_border,
                  //       size: 24,
                  //       color: Color.fromARGB(255, 0, 0, 0),
                  //     ),
                  //   ),
                  // ),
      
                  // Price - Bottom Left
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Starting at',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '@$price',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      
            // Content Container
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:
                            const Icon(Icons.star, color: Colors.white, size: 12),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.green,
                        size: 22,
                      ),
                      Text(
                        'Kakinada',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
