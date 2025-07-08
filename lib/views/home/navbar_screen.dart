import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/views/home/cart_screen.dart';
import 'package:veegify/views/home/history_screen.dart';
import 'package:veegify/views/home/home_screen.dart';
import 'package:veegify/views/home/profile_screen.dart';
import 'package:veegify/views/home/wishlist_screen.dart';
import 'package:veegify/widgets/bottom_navbar.dart';

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);

    final pages = [
      HomeScreen(),
      FavouriteScreen(),
      CartScreen(),
      HistoryScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: pages[bottomNavbarProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavbarProvider.currentIndex,
        onTap: (index) {
          bottomNavbarProvider.setIndex(index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
