// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:veegify/views/home/cart_screen.dart';
// import 'package:veegify/views/home/history_screen.dart';
// import 'package:veegify/views/home/home_screen.dart';
// import 'package:veegify/views/home/profile_screen.dart';
// import 'package:veegify/views/home/wishlist_screen.dart';
// import 'package:veegify/widgets/bottom_navbar.dart';

// class NavbarScreen extends StatelessWidget {
//   const NavbarScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);

//     final pages = [
//       HomeScreen(),
//       FavouriteScreen(),
//       CartScreen(),
//       HistoryScreen(),
//       ProfileScreen(),
//     ];

//     return Scaffold(
//       body: pages[bottomNavbarProvider.currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: bottomNavbarProvider.currentIndex,
//         onTap: (index) {
//           bottomNavbarProvider.setIndex(index);
//         },
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favourites',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: 'History',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }





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

    return WillPopScope(
      onWillPop: () async {
        // If not on home tab, go to home tab instead of exiting
        if (bottomNavbarProvider.currentIndex != 0) {
          bottomNavbarProvider.setIndex(0);
          return false; // Don't exit the app
        }
        return true; // Exit the app if already on home tab
      },
      child: Scaffold(
        body: IndexedStack(
          index: bottomNavbarProvider.currentIndex,
          children: pages,
        ),
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
      ),
    );
  }
}

// Alternative approach: Create a custom back button handler widget
class CustomBackButtonHandler extends StatelessWidget {
  final Widget child;
  final int currentTabIndex;
  
  const CustomBackButtonHandler({
    super.key,
    required this.child,
    required this.currentTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentTabIndex != 0) {
          // Navigate to home tab and clear stack
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const NavbarScreen(),
            ),
            (route) => false,
          );
          // Set the bottom navigation to home
          Provider.of<BottomNavbarProvider>(context, listen: false).setIndex(0);
          return false;
        }
        return true;
      },
      child: child,
    );
  }
}

// Usage in individual screens like HistoryScreen, ProfileScreen etc:
class ExampleScreen extends StatelessWidget {
  final int tabIndex;
  
  const ExampleScreen({super.key, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return CustomBackButtonHandler(
      currentTabIndex: tabIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Example Screen'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (tabIndex != 0) {
                // Navigate to home and clear stack
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const NavbarScreen(),
                  ),
                  (route) => false,
                );
                // Set bottom navigation to home
                Provider.of<BottomNavbarProvider>(context, listen: false).setIndex(0);
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: const Center(
          child: Text('Screen Content'),
        ),
      ),
    );
  }
}