import 'package:flutter/material.dart';
import 'package:veegify/views/home/recommended_screen.dart';

class TopRestaurantsScreen extends StatelessWidget {
  const TopRestaurantsScreen({super.key});

  final List<Map<String, dynamic>> restaurants = const [
    {
      "name": "Dosa Plaza",
      "rating": 4.2,
      "description": "All types of dosa",
      "location": "Kakinada, Gandhi nagar near varnika function hall.",
      "image":
          "https://res.cloudinary.com/dwmna13fi/image/upload/v1752579676/categories/zs5fbmetun8k3vpuxzms.jpg"
    },
    {
      "name": "Dosa Plaza",
      "rating": 4.2,
      "description": "All types of dosa",
      "location": "Kakinada, Gandhi nagar near varnika function hall.",
      "image":
          "https://res.cloudinary.com/dwmna13fi/image/upload/v1752579676/categories/zs5fbmetun8k3vpuxzms.jpg"
    },
    {
      "name": "Dosa Plaza",
      "rating": 4.2,
      "description": "All types of dosa",
      "location": "Kakinada, Gandhi nagar near varnika function hall.",
      "image":
          "https://res.cloudinary.com/dwmna13fi/image/upload/v1752579676/categories/zs5fbmetun8k3vpuxzms.jpg"
    },
    {
      "name": "Dosa Plaza",
      "rating": 4.2,
      "description": "All types of dosa",
      "location": "Kakinada, Gandhi nagar near varnika function hall.",
      "image":
          "https://res.cloudinary.com/dwmna13fi/image/upload/v1752579676/categories/zs5fbmetun8k3vpuxzms.jpg"
    },
       {
      "name": "Dosa Plaza",
      "rating": 4.2,
      "description": "All types of dosa",
      "location": "Kakinada, Gandhi nagar near varnika function hall.",
      "image":
          "https://res.cloudinary.com/dwmna13fi/image/upload/v1752579676/categories/zs5fbmetun8k3vpuxzms.jpg"
    },
    {
      "name": "Dosa Plaza",
      "rating": 4.2,
      "description": "All types of dosa",
      "location": "Kakinada, Gandhi nagar near varnika function hall.",
      "image":
          "https://res.cloudinary.com/dwmna13fi/image/upload/v1752579676/categories/zs5fbmetun8k3vpuxzms.jpg"
    },
    {
      "name": "Dosa Plaza",
      "rating": 4.2,
      "description": "All types of dosa",
      "location": "Kakinada, Gandhi nagar near varnika function hall.",
      "image":
          "https://res.cloudinary.com/dwmna13fi/image/upload/v1752579676/categories/zs5fbmetun8k3vpuxzms.jpg"
    },
  ];

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
                    const Center(
                      child: Text(
                        "Top Rated Restaurants",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // // Top Restaurants Title
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       "Top restaurants",
            //       style: TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w700,
            //       ),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 8),

            // List of Restaurants
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantDetailScreen())),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color.fromARGB(255, 196, 196, 196)),
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
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12)
                                ),
                                child: Image.network(
                                  restaurant['image'],
                                  height: 122,
                                  width: 122,
                                  fit: BoxFit.cover,
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
                              )
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
                                    restaurant['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.green
                                        ),
                                        child: const Icon(Icons.star,
                                            size: 16, color: Color.fromARGB(255, 255, 255, 255)),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        restaurant['rating'].toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    restaurant['description'],
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: Colors.green, size: 16),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          restaurant['location'],
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
        ),
      ),
    );
  }
}
