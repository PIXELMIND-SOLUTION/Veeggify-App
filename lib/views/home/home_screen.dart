import 'package:flutter/material.dart';
import 'package:veegify/model/category_model.dart';
import 'package:veegify/model/restaurant_model.dart';
import 'package:veegify/views/home/location_screen.dart';
import 'package:veegify/views/home/recommended_screen.dart';
import 'package:veegify/widgets/home/banner.dart';
import 'package:veegify/widgets/home/category_list.dart';
import 'package:veegify/widgets/home/header.dart';
import 'package:veegify/widgets/home/nearby_restaurant.dart';
import 'package:veegify/widgets/home/search.dart';
import 'package:veegify/widgets/home/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleSeeAll() {}

  @override
  Widget build(BuildContext context) {
    const List<CategoryData> categoryList = [
      CategoryData(
        imagePath:
            'https://s3-alpha-sig.figma.com/img/08e5/bf27/df4cc55a5714f906415217e838a0ea86?...',
        title: 'South\nIndian',
      ),
      CategoryData(
        imagePath:
            'https://s3-alpha-sig.figma.com/img/5473/4646/88b03f2c4d0e330b88b4c7a0ca45416c?...',
        title: 'Parota',
      ),
      CategoryData(
        imagePath:
            'https://s3-alpha-sig.figma.com/img/c320/ec94/f38e7de32fe1b0b561dafb51b4a123e2?...',
        title: 'Ice\ncream',
      ),
      CategoryData(
        imagePath:
            'https://s3-alpha-sig.figma.com/img/35d9/0673/08aa4fb27b80de19060792920bb1ff80?...',
        title: 'Shakes',
      ),
      CategoryData(
        imagePath:
            'https://s3-alpha-sig.figma.com/img/5473/4646/88b03f2c4d0e330b88b4c7a0ca45416c?...',
        title: 'Parota',
      ),
      CategoryData(
        imagePath:
            'https://s3-alpha-sig.figma.com/img/5473/4646/88b03f2c4d0e330b88b4c7a0ca45416c?...',
        title: 'Parota',
      ),
    ];

    final List<Map<String, dynamic>> nearbyRestaurants = [
      {
        'image': 'https://www.cubesnjuliennes.com/wp-content/uploads/2023/10/Best-Crispy-Plain-Dosa-Recipe.jpg',
        'name': 'Dosa Plaza',
        'rating': 4.2,
        'description': 'South Indian Dosa',
        'price': 199,
      },
      {
        'image': 'https://www.cubesnjuliennes.com/wp-content/uploads/2023/10/Best-Crispy-Plain-Dosa-Recipe.jpg',
        'name': 'Idli House',
        'rating': 4.0,
        'description': 'Soft fluffy idlis',
        'price': 99,
      },
    ];

    final List<Map<String, dynamic>> topRestaurants = [
      {
        'image': 'https://www.cubesnjuliennes.com/wp-content/uploads/2023/10/Best-Crispy-Plain-Dosa-Recipe.jpg',
        'name': 'Pizza Bite',
        'rating': 4.6,
        'description': 'Cheesy Pizzas',
        'price': 299,
      },
      {
        'image': 'https://www.cubesnjuliennes.com/wp-content/uploads/2023/10/Best-Crispy-Plain-Dosa-Recipe.jpg',
        'name': 'Burger Hub',
        'rating': 4.5,
        'description': 'Delicious Burgers',
        'price': 249,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                HomeHeader(
                  locationName: 'Hyderabad',
                  onLocationTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LocationScreen()),
                    );
                  },
                  onNotificationTap: () {},
                ),

                const SizedBox(height: 16),

                // Search bar

                SearchBarWithFilter(),

                const SizedBox(height: 16),

                SectionHeader(
                  title: 'Categories',
                  onSeeAll: _handleSeeAll,
                ),

                const SizedBox(height: 10),

                // Categories
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      final category = categoryList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: CategoryCard(
                          imagePath: category.imagePath,
                          title: category.title,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Promotional banner

                PromoBanner(
                  titleLine1: 'Order your favorite',
                  titleLine2: 'food!',
                  buttonText: 'Order now',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RecommendedScreen()));
                  },
                  imageAssetPath: 'assets/images/scooter.png',
                ),

                const SizedBox(height: 16),

                // Nearby restaurants header
                SectionHeader(
                  title: 'Nearby restaurants',
                  onSeeAll: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecommendedScreen()),
                    );
                  },
                ),

                const SizedBox(height: 10),

                // Restaurant cards

                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: nearbyRestaurants.length,
                    itemBuilder: (context, index) {
                      final item = nearbyRestaurants[index];
                      return RestaurantCard(
                        imagePath: item['image'],
                        name: item['name'],
                        rating: item['rating'],
                        description: item['description'],
                        price: item['price'],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Top restaurants header
                SectionHeader(
                  title: 'Top restaurants in Kakinada',
                  onSeeAll: () {},
                ),

                const SizedBox(height: 10),

                // Top restaurant cards
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topRestaurants.length,
                    itemBuilder: (context, index) {
                      final item = topRestaurants[index];
                      return RestaurantCard(
                        imagePath: item['image'],
                        name: item['name'],
                        rating: item['rating'],
                        description: item['description'],
                        price: item['price'],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
