// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:veegify/helper/storage_helper.dart';
// import 'package:veegify/model/category_model.dart';
// import 'package:veegify/model/restaurant_model.dart';
// import 'package:veegify/provider/category_provider.dart';
// import 'package:veegify/provider/location_provider.dart';
// import 'package:veegify/views/home/location_screen.dart';
// import 'package:veegify/views/home/recommended_screen.dart';
// import 'package:veegify/widgets/home/banner.dart';
// import 'package:veegify/widgets/home/category_list.dart';
// import 'package:veegify/widgets/home/header.dart';
// import 'package:veegify/widgets/home/nearby_restaurant.dart';
// import 'package:veegify/widgets/home/search.dart';
// import 'package:veegify/widgets/home/section_header.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool _isLoadingCurrentLocation = false;
//   String? userId;

// @override
// void initState() {
//   super.initState();

//   // Load categories right away
//   Future.microtask(() {
//     Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
//   });

//   // Load user ID and location after first frame
//   WidgetsBinding.instance.addPostFrameCallback((_) async {
//     await _loadUserId();
//     await _handleCurrentLocation();
//   });
// }

// Future<void> _loadUserId() async {
//   final user = UserPreferences.getUser();
//   if (user != null) {
//     setState(() {
//       userId = user.userId;
//     });
//     print("User ID loaded: $userId");
//   } else {
//     print("User not found in preferences.");
//   }
// }

// Future<void> _handleCurrentLocation() async {
//     setState(() {
//       _isLoadingCurrentLocation = true;
//     });

//     try {
//       final locationProvider =
//           Provider.of<LocationProvider>(context, listen: false);
//       await locationProvider.initLocation(userId.toString());

//       if (mounted) {
//         if (locationProvider.hasError) {
//           _showError(locationProvider.errorMessage);
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         _showError("Failed to get current location: ${e.toString()}");
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoadingCurrentLocation = false;
//         });
//       }
//     }
//   }

//   void _showError(String message) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   void _handleSeeAll() {}

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> nearbyRestaurants = [
//       {
//         'image':
//             'https://www.cubesnjuliennes.com/wp-content/uploads/2023/10/Best-Crispy-Plain-Dosa-Recipe.jpg',
//         'name': 'Dosa Plaza',
//         'rating': 4.2,
//         'description': 'South Indian Dosa',
//         'price': 199,
//       },
//       {
//         'image':
//             'https://www.cubesnjuliennes.com/wp-content/uploads/2023/10/Best-Crispy-Plain-Dosa-Recipe.jpg',
//         'name': 'Idli House',
//         'rating': 4.0,
//         'description': 'Soft fluffy idlis',
//         'price': 99,
//       },
//     ];

//     final List<Map<String, dynamic>> topRestaurants = [
//       {
//         'image':
//             'https://www.cubesnjuliennes.com/wp-content/uploads/2023/10/Best-Crispy-Plain-Dosa-Recipe.jpg',
//         'name': 'Pizza Bite',
//         'rating': 4.6,
//         'description': 'Cheesy Pizzas',
//         'price': 299,
//       },
//       {
//         'image':
//             'https://www.cubesnjuliennes.com/wp-content/uploads/2023/10/Best-Crispy-Plain-Dosa-Recipe.jpg',
//         'name': 'Burger Hub',
//         'rating': 4.5,
//         'description': 'Delicious Burgers',
//         'price': 249,
//       },
//     ];

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 10),

//                 HomeHeader(
//                   userId: userId.toString(),
//                   onLocationTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const LocationScreen()),
//                     );
//                   },
//                   onNotificationTap: () {},
//                 ),

//                 const SizedBox(height: 16),

//                 // Search bar

//                 SearchBarWithFilter(),

//                 const SizedBox(height: 16),

//                 SectionHeader(
//                   title: 'Categories',
//                   onSeeAll: _handleSeeAll,
//                 ),

//                 const SizedBox(height: 10),

//                 // Categories
//                 Consumer<CategoryProvider>(
//                   builder: (context, categoryProvider, _) {
//                     final categories = categoryProvider.categories;

//                     if (categoryProvider.isLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     if (categories.isEmpty) {
//                       return const Text("No categories found");
//                     }

//                     return SizedBox(
//                       height: 120,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: categories.length,
//                         itemBuilder: (context, index) {
//                           final category = categories[index];
//                           return Padding(
//                             padding: const EdgeInsets.only(right: 12),
//                             child: CategoryCard(
//                               imagePath: category.imageUrl,
//                               title: category.categoryName,
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),

//                 const SizedBox(height: 16),

//                 // Promotional banner

//                 PromoBanner(
//                   titleLine1: 'Order your favorite',
//                   titleLine2: 'food!',
//                   buttonText: 'Order now',
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => const RecommendedScreen()));
//                   },
//                   imageAssetPath: 'assets/images/scooter.png',
//                 ),

//                 const SizedBox(height: 16),

//                 // Nearby restaurants header
//                 SectionHeader(
//                   title: 'Nearby restaurants',
//                   onSeeAll: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const RecommendedScreen()),
//                     );
//                   },
//                 ),

//                 const SizedBox(height: 10),

//                 // Restaurant cards

//                 SizedBox(
//                   height: 250,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: nearbyRestaurants.length,
//                     itemBuilder: (context, index) {
//                       final item = nearbyRestaurants[index];
//                       return RestaurantCard(
//                         imagePath: item['image'],
//                         name: item['name'],
//                         rating: item['rating'],
//                         description: item['description'],
//                         price: item['price'],
//                       );
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 // Top restaurants header
//                 SectionHeader(
//                   title: 'Top restaurants in Kakinada',
//                   onSeeAll: () {},
//                 ),

//                 const SizedBox(height: 10),

//                 // Top restaurant cards
//                 SizedBox(
//                   height: 250,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: topRestaurants.length,
//                     itemBuilder: (context, index) {
//                       final item = topRestaurants[index];
//                       return RestaurantCard(
//                         imagePath: item['image'],
//                         name: item['name'],
//                         rating: item['rating'],
//                         description: item['description'],
//                         price: item['price'],
//                       );
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:veegify/helper/storage_helper.dart';
// import 'package:veegify/provider/category_provider.dart';
// import 'package:veegify/provider/location_provider.dart';
// import 'package:veegify/provider/nearby_restaurants_provider.dart';
// import 'package:veegify/views/home/location_screen.dart';
// import 'package:veegify/views/home/recommended_screen.dart';
// import 'package:veegify/widgets/home/banner.dart';
// import 'package:veegify/widgets/home/category_list.dart';
// import 'package:veegify/widgets/home/header.dart';
// import 'package:veegify/widgets/home/nearby_restaurant.dart';
// import 'package:veegify/widgets/home/search.dart';
// import 'package:veegify/widgets/home/section_header.dart';
// import 'package:veegify/widgets/home/top_restaurants.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool _isInitializing = true;
//   String? userId;

//   @override
//   void initState() {
//     super.initState();
//     _initializeData();
//   }

//   Future<void> _initializeData() async {
//     try {
//       // Load user ID first
//       await _loadUserId();

//       // Initialize providers in parallel
//       await Future.wait([
//         Provider.of<CategoryProvider>(context, listen: false).fetchCategories(),
//         Provider.of<RestaurantProvider>(context, listen: false).getNearbyRestaurants(userId.toString()),
//         if (userId != null) _handleCurrentLocation(),
//       ]);
//     } catch (e) {
//       debugPrint('Initialization error: $e');
//     } finally {
//       if (mounted) {
//         setState(() => _isInitializing = false);
//       }
//     }
//   }

//   Future<void> _loadUserId() async {
//     final user = UserPreferences.getUser();
//     if (user != null && mounted) {
//       setState(() {
//         userId = user.userId;
//       });
//     }
//   }

//   Future<void> _handleCurrentLocation() async {
//     try {
//       final locationProvider = Provider.of<LocationProvider>(context, listen: false);
//       await locationProvider.initLocation(userId.toString());
//     } catch (e) {
//       debugPrint('Location error: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Location error: ${e.toString()}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   void _handleSeeAll() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const RecommendedScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {

//     final List<Map<String, dynamic>> nearbyRestaurants = [
//       {
//         'image': 'https://www.cubesnjuliennes.com/wp-content/uploads/2023/10/Best-Crispy-Plain-Dosa-Recipe.jpg',
//         'name': 'Dosa Plaza',
//         'rating': 4.2,
//         'description': 'South Indian Dosa',
//         'price': 199,
//       },
//       // Add more restaurants...
//     ];

//     return Scaffold(
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: _initializeData,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 10),
//                 HomeHeader(
//                   userId: userId ?? 'unknown',
//                   onLocationTap: () async {
//                     await Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const LocationScreen()),
//                     );
//                     if (mounted) await _handleCurrentLocation();
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 const SearchBarWithFilter(),
//                 const SizedBox(height: 16),
//                 SectionHeader(
//                   title: 'Categories',
//                   onSeeAll: _handleSeeAll,
//                 ),
//                 const SizedBox(height: 10),
//                 _buildCategories(),
//                 const SizedBox(height: 16),
//                 PromoBanner(
//                   titleLine1: 'Order your favorite',
//                   titleLine2: 'food!',
//                   buttonText: 'Order now',
//                   imageAssetPath: "assets/images/scooter.png",
//                   onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const RecommendedScreen()),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 SectionHeader(
//                   title: 'Nearby restaurants',
//                   onSeeAll: _handleSeeAll,
//                 ),
//                 const SizedBox(height: 10),
//                 _buildRestaurantList(),
//                 const SizedBox(height: 16),
//                 SectionHeader(
//                   title: 'Top restaurants in your area',
//                   onSeeAll: _handleSeeAll,
//                 ),
//                 const SizedBox(height: 10),
//                 _buildTopRestaurants(), // Replace with actual top restaurants
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCategories() {
//     return Consumer<CategoryProvider>(
//       builder: (context, provider, _) {
//         if (provider.isLoading) {
//           return const SizedBox(
//             height: 120,
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }
//         if (provider.categories.isEmpty) {
//           return const SizedBox(
//             height: 120,
//             child: Center(child: Text('No categories available')),
//           );
//         }
//         return SizedBox(
//           height: 120,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: provider.categories.length,
//             itemBuilder: (context, index) {
//               final category = provider.categories[index];
//               return Padding(
//                 padding: const EdgeInsets.only(right: 12),
//                 child: CategoryCard(
//                   imagePath: category.imageUrl,
//                   title: category.categoryName,
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

// Widget _buildRestaurantList() {
//   return Consumer<RestaurantProvider>(
//     builder: (context, provider, _) {
//       if (provider.isLoading) {
//         return const SizedBox(
//           height: 250,
//           child: Center(child: CircularProgressIndicator()),
//         );
//       }

//       if (provider.nearbyRestaurants.isEmpty) {
//         return const SizedBox(
//           height: 250,
//           child: Center(child: Text('No nearby restaurants found.')),
//         );
//       }

//       return SizedBox(
//         height: 270,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: provider.nearbyRestaurants.length,
//           itemBuilder: (context, index) {
//             final restaurant = provider.nearbyRestaurants[index];
//             return RestaurantCard(
//               imagePath: restaurant.imageUrl,
//               name: restaurant.restaurantName,
//               rating: restaurant.rating.toDouble(),
//               description: restaurant.description,
//               price: restaurant.startingPrice,
//             );
//           },
//         ),
//       );
//     },
//   );
// }

// Widget _buildTopRestaurants() {
//   return Consumer<RestaurantProvider>(
//     builder: (context, provider, _) {
//       if (provider.isLoading) {
//         return const SizedBox(
//           height: 300,
//           child: Center(child: CircularProgressIndicator()),
//         );
//       }

//       if (provider.nearbyRestaurants.isEmpty) {
//         return const SizedBox(
//           height: 300,
//           child: Center(child: Text('No nearby restaurants found.')),
//         );
//       }

//       return SizedBox(
//         height: 270,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: provider.nearbyRestaurants.length,
//           itemBuilder: (context, index) {
//             final restaurant = provider.nearbyRestaurants[index];
//             return TopRestaurantCard(
//               imagePath: restaurant.imageUrl,
//               name: restaurant.restaurantName,
//               rating: restaurant.rating.toDouble(),
//               description: restaurant.description,
//               price: restaurant.startingPrice,
//             );
//           },
//         ),
//       );
//     },
//   );
// }

// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/helper/storage_helper.dart';
import 'package:veegify/provider/category_provider.dart';
import 'package:veegify/provider/location_provider.dart';
import 'package:veegify/provider/nearby_restaurants_provider.dart';
import 'package:veegify/provider/top_restaurants_provider.dart';
import 'package:veegify/views/Category/top_restaurants_screen.dart';
import 'package:veegify/views/category/category_screen.dart';
import 'package:veegify/views/category/nearby_screen.dart';
import 'package:veegify/views/home/location_screen.dart';
import 'package:veegify/views/home/recommended_screen.dart';
import 'package:veegify/widgets/home/banner.dart';
import 'package:veegify/widgets/home/category_list.dart';
import 'package:veegify/widgets/home/header.dart';
import 'package:veegify/widgets/home/nearby_restaurant.dart';
import 'package:veegify/widgets/home/search.dart';
import 'package:veegify/widgets/home/section_header.dart';
import 'package:veegify/widgets/home/top_restaurants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _isInitializing = true;
  String? userId;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _initializeData();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Future<void> _initializeData() async {
    try {
      // Load user ID first
      await _loadUserId();
      await _handleCurrentLocation();

      // Initialize providers in parallel
      await Future.wait([
        Provider.of<CategoryProvider>(context, listen: false).fetchCategories(),
        Provider.of<RestaurantProvider>(context, listen: false)
            .getNearbyRestaurants(userId.toString()),
        Provider.of<TopRestaurantsProvider>(context, listen: false)
            .getTopNearbyRestaurants(userId.toString()),
        // if (userId != null) _handleCurrentLocation(),
      ]);
    } catch (e) {
      debugPrint('Initialization error: $e');
    } finally {
      if (mounted) {
        setState(() => _isInitializing = false);
      }
    }
  }

  Future<void> _loadUserId() async {
    final user = UserPreferences.getUser();
    if (user != null && mounted) {
      setState(() {
        userId = user.userId;
      });
    }
  }

  Future<void> _handleCurrentLocation() async {
    try {
      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);
      await locationProvider.initLocation(userId.toString());
    } catch (e) {
      debugPrint('Location error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Location error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Shimmer effect widget
  Widget _buildShimmer({required Widget child}) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                _shimmerController.value - 0.3,
                _shimmerController.value,
                _shimmerController.value + 0.3,
              ],
              colors: const [
                Color(0xFFEBEBF4),
                Color(0xFFF4F4F4),
                Color(0xFFEBEBF4),
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: child,
    );
  }

  // Category skeleton loader
  Widget _buildCategorySkeleton() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _buildShimmer(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 60,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Restaurant card skeleton loader
  Widget _buildRestaurantSkeleton() {
    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 12),
            width: 176,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image skeleton
                _buildShimmer(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                // Content skeleton
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmer(
                        child: Container(
                          width: 120,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildShimmer(
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 30,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildShimmer(
                        child: Container(
                          width: 100,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildShimmer(
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 60,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _initializeData,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                HomeHeader(
                  userId: userId ?? 'unknown',
                  onLocationTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LocationScreen()),
                    );
                    if (mounted) await _handleCurrentLocation();
                  },
                ),
                const SizedBox(height: 16),
                const SearchBarWithFilter(),
                const SizedBox(height: 16),
                SectionHeader(
                  title: 'Categories',
                  onSeeAll: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CategoryScreen()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _buildCategories(),
                const SizedBox(height: 16),
                PromoBanner(
                  titleLine1: 'Order your favorite',
                  titleLine2: 'food!',
                  buttonText: 'Order now',
                  imageAssetPath: "assets/images/scooter.png",
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const RestaurantDetailScreen()),
                  ),
                ),
                const SizedBox(height: 16),
                SectionHeader(
                  title: 'Nearby restaurants',
                  onSeeAll: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NearbyScreen()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _buildRestaurantList(),
                const SizedBox(height: 16),
                SectionHeader(
                  title: 'Top restaurants in your area',
                  onSeeAll: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TopRestaurantsScreen()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _buildTopRestaurants(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Consumer<CategoryProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return _buildCategorySkeleton();
        }
        if (provider.categories.isEmpty) {
          return const SizedBox(
            height: 120,
            child: Center(child: Text('No categories available')),
          );
        }
        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.categories.length,
            itemBuilder: (context, index) {
              final category = provider.categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CategoryCard(
                  imagePath: category.imageUrl,
                  title: category.categoryName,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildRestaurantList() {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return _buildRestaurantSkeleton();
        }

        if (provider.nearbyRestaurants.isEmpty) {
          return const SizedBox(
            height: 250,
            child: Center(child: Text('No nearby restaurants found.')),
          );
        }

        return SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.nearbyRestaurants.length,
            itemBuilder: (context, index) {
              final restaurant = provider.nearbyRestaurants[index];
              return RestaurantCard(
                imagePath: restaurant.imageUrl,
                name: restaurant.restaurantName,
                rating: restaurant.rating.toDouble(),
                description: restaurant.description,
                price: restaurant.startingPrice,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTopRestaurants() {
    return Consumer<TopRestaurantsProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return _buildRestaurantSkeleton();
        }

        if (provider.nearbyRestaurants.isEmpty) {
          return const SizedBox(
            height: 300,
            child: Center(child: Text('No nearby restaurants found.')),
          );
        }

        return SizedBox(
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.nearbyRestaurants.length,
            itemBuilder: (context, index) {
              final restaurant = provider.nearbyRestaurants[index];
              return TopRestaurantCard(
                imagePath: restaurant.imageUrl,
                name: restaurant.restaurantName,
                rating: restaurant.rating.toDouble(),
                description: restaurant.description,
                price: restaurant.startingPrice,
              );
            },
          ),
        );
      },
    );
  }
}
