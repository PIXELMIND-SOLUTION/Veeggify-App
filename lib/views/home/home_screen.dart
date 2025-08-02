import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/helper/storage_helper.dart';
import 'package:veegify/provider/banner_provider.dart';
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

// Main HomeScreen wrapper that accepts scroll controller
class HomeScreenWithController extends StatelessWidget {
  final ScrollController scrollController;

  const HomeScreenWithController({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return HomeScreen(scrollController: scrollController);
  }
}

class HomeScreen extends StatefulWidget {
  final ScrollController? scrollController;

  const HomeScreen({super.key, this.scrollController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInitializing = true;
  String? userId;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await _loadUserId();
      await _handleCurrentLocation();
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
      Provider.of<RestaurantProvider>(context, listen: false)
          .getNearbyRestaurants(userId.toString());
      Provider.of<TopRestaurantsProvider>(context, listen: false)
          .getTopRestaurants(userId.toString());
      Provider.of<BannerProvider>(context, listen: false).fetchBanners();

      // await Future.wait([
      //   Provider.of<CategoryProvider>(context, listen: false).fetchCategories(),
      //   Provider.of<RestaurantProvider>(context, listen: false)
      //       .getNearbyRestaurants(userId.toString()),
      //   Provider.of<TopRestaurantsProvider>(context, listen: false)
      //       .getTopRestaurants(userId.toString()),
      //       Provider.of<BannerProvider>(context, listen: false).fetchBanners(),
      // ]);
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

  Widget _buildCategorySkeleton() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
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
          );
        },
      ),
    );
  }

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
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
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
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
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
            controller: widget.scrollController,
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
                const PromoBanner(),
                const SizedBox(height: 16),
                SectionHeader(
                  title: 'Nearby restaurants',
                  onSeeAll: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              NearbyScreen(userId: userId.toString())),
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
                          builder: (_) =>
                              TopRestaurantsScreen(userId: userId.toString())),
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
                  id: category.id,
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
          height: 360,
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

        if (provider.topRestaurants.isEmpty) {
          return const SizedBox(
            height: 300,
            child: Center(child: Text('No nearby restaurants found.')),
          );
        }

        return SizedBox(
          height: 290,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.topRestaurants.length,
            itemBuilder: (context, index) {
              final restaurant = provider.topRestaurants[index];
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
