import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:veegify/provider/AddressProvider/address_provider.dart';
import 'package:veegify/provider/AuthProvider/auth_provider.dart';
import 'package:veegify/provider/BannerProvider/banner_provider.dart';
import 'package:veegify/provider/BookingProvider/booking_provider.dart';
import 'package:veegify/provider/CartProvider/cart_provider.dart';
import 'package:veegify/provider/CategoryProvider/category_provider.dart';
import 'package:veegify/provider/LocationProvider/location_provider.dart';
import 'package:veegify/provider/RestaurantProvider/nearby_restaurants_provider.dart';
import 'package:veegify/provider/RestaurantProvider/restaurant_products_provider.dart';
import 'package:veegify/provider/RestaurantProvider/top_restaurants_provider.dart';
import 'package:veegify/provider/WishListProvider/wishlist_provider.dart';
import 'package:veegify/services/BookingService/booking_service.dart';
import 'package:veegify/widgets/bottom_navbar.dart';
import 'package:veegify/views/splash_screen.dart';

import 'provider/address_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      final orderService = OrderService(baseUrl: 'http://31.97.206.144:5051');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavbarProvider>(
            create: (_) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => TopRestaurantsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider(service: orderService)),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => BannerProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProductsProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, // Sets screen background white
          fontFamily: 'Poppins',
          brightness:
              Brightness.light, // Ensures textTheme is based on light mode
          textTheme: const TextTheme(
            displayLarge: TextStyle(color: Colors.black),
            displayMedium: TextStyle(color: Colors.black),
            displaySmall: TextStyle(color: Colors.black),
            headlineLarge: TextStyle(color: Colors.black),
            headlineMedium: TextStyle(color: Colors.black),
            headlineSmall: TextStyle(color: Colors.black),
            titleLarge: TextStyle(color: Colors.black),
            titleMedium: TextStyle(color: Colors.black),
            titleSmall: TextStyle(color: Colors.black),
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black),
            bodySmall: TextStyle(color: Colors.black),
            labelLarge: TextStyle(color: Colors.black),
            labelMedium: TextStyle(color: Colors.black),
            labelSmall: TextStyle(color: Colors.black),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
      ),
    );
  }
}
