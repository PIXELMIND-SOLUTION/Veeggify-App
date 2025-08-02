

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

//     return WillPopScope(
//       onWillPop: () async {
//         // If not on home tab, go to home tab instead of exiting
//         if (bottomNavbarProvider.currentIndex != 0) {
//           bottomNavbarProvider.setIndex(0);
//           return false; // Don't exit the app
//         }
//         return true; // Exit the app if already on home tab
//       },
//       child: Scaffold(
//         body: IndexedStack(
//           index: bottomNavbarProvider.currentIndex,
//           children: pages,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: bottomNavbarProvider.currentIndex,
//           onTap: (index) {
//             bottomNavbarProvider.setIndex(index);
//           },
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: Colors.black,
//           unselectedItemColor: Colors.grey,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.favorite),
//               label: 'Favourites',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.shopping_cart),
//               label: 'Cart',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.list),
//               label: 'History',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'Profile',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Alternative approach: Create a custom back button handler widget
// class CustomBackButtonHandler extends StatelessWidget {
//   final Widget child;
//   final int currentTabIndex;
  
//   const CustomBackButtonHandler({
//     super.key,
//     required this.child,
//     required this.currentTabIndex,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (currentTabIndex != 0) {
//           // Navigate to home tab and clear stack
//           Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(
//               builder: (context) => const NavbarScreen(),
//             ),
//             (route) => false,
//           );
//           // Set the bottom navigation to home
//           Provider.of<BottomNavbarProvider>(context, listen: false).setIndex(0);
//           return false;
//         }
//         return true;
//       },
//       child: child,
//     );
//   }
// }

// // Usage in individual screens like HistoryScreen, ProfileScreen etc:
// class ExampleScreen extends StatelessWidget {
//   final int tabIndex;
  
//   const ExampleScreen({super.key, required this.tabIndex});

//   @override
//   Widget build(BuildContext context) {
//     return CustomBackButtonHandler(
//       currentTabIndex: tabIndex,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Example Screen'),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               if (tabIndex != 0) {
//                 // Navigate to home and clear stack
//                 Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(
//                     builder: (context) => const NavbarScreen(),
//                   ),
//                   (route) => false,
//                 );
//                 // Set bottom navigation to home
//                 Provider.of<BottomNavbarProvider>(context, listen: false).setIndex(0);
//               } else {
//                 Navigator.of(context).pop();
//               }
//             },
//           ),
//         ),
//         body: const Center(
//           child: Text('Screen Content'),
//         ),
//       ),
//     );
//   }
// }









// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:provider/provider.dart';
// import 'package:veegify/views/home/cart_screen.dart';
// import 'package:veegify/views/home/history_screen.dart';
// import 'package:veegify/views/home/home_screen.dart';
// import 'package:veegify/views/home/profile_screen.dart';
// import 'package:veegify/views/home/wishlist_screen.dart';
// import 'package:veegify/widgets/bottom_navbar.dart';

// class NavbarScreen extends StatefulWidget {
//   const NavbarScreen({super.key});

//   @override
//   State<NavbarScreen> createState() => _NavbarScreenState();
// }

// class _NavbarScreenState extends State<NavbarScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<Offset> _offsetAnimation;
//   bool _isBottomNavVisible = true;
//   ScrollController? _currentScrollController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
    
//     _offsetAnimation = Tween<Offset>(
//       begin: Offset.zero,
//       end: const Offset(0.0, 1.0),
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _currentScrollController?.removeListener(_scrollListener);
//     super.dispose();
//   }

//   void _scrollListener() {
//     if (_currentScrollController == null) return;
    
//     const double scrollThreshold = 10.0;
    
//     if (_currentScrollController!.position.userScrollDirection == 
//         ScrollDirection.reverse) {
//       // Scrolling down - hide bottom nav
//       if (_isBottomNavVisible) {
//         setState(() {
//           _isBottomNavVisible = false;
//         });
//         _animationController.forward();
//       }
//     } else if (_currentScrollController!.position.userScrollDirection == 
//                ScrollDirection.forward) {
//       // Scrolling up - show bottom nav
//       if (!_isBottomNavVisible) {
//         setState(() {
//           _isBottomNavVisible = true;
//         });
//         _animationController.reverse();
//       }
//     }
//   }

//   void _attachScrollController(ScrollController? controller) {
//     // Remove previous listener
//     _currentScrollController?.removeListener(_scrollListener);
    
//     // Attach new listener
//     _currentScrollController = controller;
//     _currentScrollController?.addListener(_scrollListener);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);

//     final pages = [
//       ScrollableHomeScreen(onScrollControllerCreated: _attachScrollController),
//       ScrollableFavouriteScreen(onScrollControllerCreated: _attachScrollController),
//       ScrollableCartScreen(onScrollControllerCreated: _attachScrollController),
//       // ScrollableHistoryScreen(onScrollControllerCreated: _attachScrollController),
//       ScrollableProfileScreen(onScrollControllerCreated: _attachScrollController),
//     ];

//     return WillPopScope(
//       onWillPop: () async {
//         if (bottomNavbarProvider.currentIndex != 0) {
//           bottomNavbarProvider.setIndex(0);
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         body: IndexedStack(
//           index: bottomNavbarProvider.currentIndex,
//           children: pages,
//         ),
//        bottomNavigationBar: _isBottomNavVisible ? BottomNavigationBar(
//   currentIndex: bottomNavbarProvider.currentIndex,
//   onTap: (index) {
//     bottomNavbarProvider.setIndex(index);
//     // Reset bottom nav visibility when switching tabs
//     if (!_isBottomNavVisible) {
//       setState(() {
//         _isBottomNavVisible = true;
//       });
//     }
//   },
//   type: BottomNavigationBarType.fixed,
//   selectedItemColor: Colors.black,
//   unselectedItemColor: Colors.grey,
//   elevation: 8,
//   backgroundColor: Colors.white,
//   items: const [
//     BottomNavigationBarItem(
//       icon: Icon(Icons.home),
//       label: 'Home',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.favorite),
//       label: 'Favourites',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.shopping_cart),
//       label: 'Cart',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.list),
//       label: 'History',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.person),
//       label: 'Profile',
//     ),
//   ],
// ) : null,
//       ),
//     );
//   }
// }

// // Wrapper for HomeScreen to provide scroll controller
// class ScrollableHomeScreen extends StatefulWidget {
//   final Function(ScrollController?) onScrollControllerCreated;
  
//   const ScrollableHomeScreen({
//     super.key,
//     required this.onScrollControllerCreated,
//   });

//   @override
//   State<ScrollableHomeScreen> createState() => _ScrollableHomeScreenState();
// }

// class _ScrollableHomeScreenState extends State<ScrollableHomeScreen> {
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     widget.onScrollControllerCreated(_scrollController);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return HomeScreenWithController(scrollController: _scrollController);
//   }
// }

// // Similar wrappers for other screens
// class ScrollableFavouriteScreen extends StatefulWidget {
//   final Function(ScrollController?) onScrollControllerCreated;
  
//   const ScrollableFavouriteScreen({
//     super.key,
//     required this.onScrollControllerCreated,
//   });

//   @override
//   State<ScrollableFavouriteScreen> createState() => _ScrollableFavouriteScreenState();
// }

// class _ScrollableFavouriteScreenState extends State<ScrollableFavouriteScreen> {
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     widget.onScrollControllerCreated(_scrollController);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FavouriteScreenWithController(scrollController: _scrollController);
//   }
// }

// class ScrollableCartScreen extends StatefulWidget {
//   final Function(ScrollController?) onScrollControllerCreated;
  
//   const ScrollableCartScreen({
//     super.key,
//     required this.onScrollControllerCreated,
//   });

//   @override
//   State<ScrollableCartScreen> createState() => _ScrollableCartScreenState();
// }

// class _ScrollableCartScreenState extends State<ScrollableCartScreen> {
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     widget.onScrollControllerCreated(_scrollController);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CartScreenWithController(scrollController: _scrollController);
//   }
// }

// // class ScrollableHistoryScreen extends StatefulWidget {
// //   final Function(ScrollController?) onScrollControllerCreated;
  
// //   const ScrollableHistoryScreen({
// //     super.key,
// //     required this.onScrollControllerCreated,
// //   });

// //   @override
// //   State<ScrollableHistoryScreen> createState() => _ScrollableHistoryScreenState();
// // }

// // class _ScrollableHistoryScreenState extends State<ScrollableHistoryScreen> {
// //   late ScrollController _scrollController;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _scrollController = ScrollController();
// //     widget.onScrollControllerCreated(_scrollController);
// //   }

// //   @override
// //   void dispose() {
// //     _scrollController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return HistoryScreenWithController(scrollController: _scrollController);
// //   }
// // }

// class ScrollableProfileScreen extends StatefulWidget {
//   final Function(ScrollController?) onScrollControllerCreated;
  
//   const ScrollableProfileScreen({
//     super.key,
//     required this.onScrollControllerCreated,
//   });

//   @override
//   State<ScrollableProfileScreen> createState() => _ScrollableProfileScreenState();
// }

// class _ScrollableProfileScreenState extends State<ScrollableProfileScreen> {
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     widget.onScrollControllerCreated(_scrollController);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ProfileScreenWithController(scrollController: _scrollController);
//   }
// }









import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:veegify/provider/cart_provider.dart';
import 'package:veegify/views/home/cart_screen.dart';
import 'package:veegify/views/home/history_screen.dart';
import 'package:veegify/views/home/home_screen.dart';
import 'package:veegify/views/home/profile_screen.dart';
import 'package:veegify/views/home/wishlist_screen.dart';
import 'package:veegify/widgets/bottom_navbar.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  bool _isBottomNavVisible = true;
  ScrollController? _currentScrollController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 1.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _currentScrollController?.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_currentScrollController == null) return;
    
    const double scrollThreshold = 10.0;
    
    if (_currentScrollController!.position.userScrollDirection == 
        ScrollDirection.reverse) {
      // Scrolling down - hide bottom nav
      if (_isBottomNavVisible) {
        setState(() {
          _isBottomNavVisible = false;
        });
      }
    } else if (_currentScrollController!.position.userScrollDirection == 
               ScrollDirection.forward) {
      // Scrolling up - show bottom nav
      if (!_isBottomNavVisible) {
        setState(() {
          _isBottomNavVisible = true;
        });
      }
    }
  }

  void _attachScrollController(ScrollController? controller) {
    // Remove previous listener
    _currentScrollController?.removeListener(_scrollListener);
    
    // Attach new listener
    _currentScrollController = controller;
    _currentScrollController?.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);

    final pages = [
      ScrollableHomeScreen(onScrollControllerCreated: _attachScrollController),
      ScrollableFavouriteScreen(onScrollControllerCreated: _attachScrollController),
      ScrollableCartScreen(onScrollControllerCreated: _attachScrollController),
      ScrollableHistoryScreen(onScrollControllerCreated: _attachScrollController),
      ScrollableProfileScreen(onScrollControllerCreated: _attachScrollController),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (bottomNavbarProvider.currentIndex != 0) {
          bottomNavbarProvider.setIndex(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: IndexedStack(
          index: bottomNavbarProvider.currentIndex,
          children: pages,
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cart Summary Bar (only show when there are items and not on cart screen)
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                if (cartProvider.items.isEmpty || bottomNavbarProvider.currentIndex == 2) {
                  return const SizedBox.shrink();
                }
                
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: _isBottomNavVisible ? 60 : 0,
                  child: _isBottomNavVisible ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, -2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Cart Icon with Item Count
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            if (cartProvider.totalItems > 0)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    '${cartProvider.totalItems}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        
                        const SizedBox(width: 12),
                        
                        // Item Count and Price
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${cartProvider.totalItems} item${cartProvider.totalItems > 1 ? 's' : ''}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Plus taxes and charges',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Checkout Button
                        GestureDetector(
                          onTap: () {
                            bottomNavbarProvider.setIndex(2); // Navigate to cart
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '₹${cartProvider.totalPayable}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Checkout',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.green,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) : const SizedBox.shrink(),
                );
              },
            ),
            
            // Bottom Navigation Bar
            if (_isBottomNavVisible)
              BottomNavigationBar(
                currentIndex: bottomNavbarProvider.currentIndex,
                onTap: (index) {
                  bottomNavbarProvider.setIndex(index);
                  // Reset bottom nav visibility when switching tabs
                  if (!_isBottomNavVisible) {
                    setState(() {
                      _isBottomNavVisible = true;
                    });
                  }
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                elevation: 8,
                backgroundColor: Colors.white,
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favourites',
                  ),
                  BottomNavigationBarItem(
                    icon: Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                        return Stack(
                          children: [
                            const Icon(Icons.shopping_cart),
                            if (cartProvider.totalItems > 0)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 12,
                                    minHeight: 12,
                                  ),
                                  child: Text(
                                    '${cartProvider.totalItems}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    label: 'Cart',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'History',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// Wrapper for HomeScreen to provide scroll controller
class ScrollableHomeScreen extends StatefulWidget {
  final Function(ScrollController?) onScrollControllerCreated;
  
  const ScrollableHomeScreen({
    super.key,
    required this.onScrollControllerCreated,
  });

  @override
  State<ScrollableHomeScreen> createState() => _ScrollableHomeScreenState();
}

class _ScrollableHomeScreenState extends State<ScrollableHomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    widget.onScrollControllerCreated(_scrollController);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenWithController(scrollController: _scrollController);
  }
}

// Similar wrappers for other screens
class ScrollableFavouriteScreen extends StatefulWidget {
  final Function(ScrollController?) onScrollControllerCreated;
  
  const ScrollableFavouriteScreen({
    super.key,
    required this.onScrollControllerCreated,
  });

  @override
  State<ScrollableFavouriteScreen> createState() => _ScrollableFavouriteScreenState();
}

class _ScrollableFavouriteScreenState extends State<ScrollableFavouriteScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    widget.onScrollControllerCreated(_scrollController);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FavouriteScreenWithController(scrollController: _scrollController);
  }
}

class ScrollableCartScreen extends StatefulWidget {
  final Function(ScrollController?) onScrollControllerCreated;
  
  const ScrollableCartScreen({
    super.key,
    required this.onScrollControllerCreated,
  });

  @override
  State<ScrollableCartScreen> createState() => _ScrollableCartScreenState();
}

class _ScrollableCartScreenState extends State<ScrollableCartScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    widget.onScrollControllerCreated(_scrollController);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CartScreenWithController(scrollController: _scrollController);
  }
}


class ScrollableHistoryScreen extends StatefulWidget {
  final Function(ScrollController?) onScrollControllerCreated;
  
  const ScrollableHistoryScreen({
    super.key,
    required this.onScrollControllerCreated,
  });

  @override
  State<ScrollableHistoryScreen> createState() => _ScrollableHistoryScreenState();
}

class _ScrollableHistoryScreenState extends State<ScrollableHistoryScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    widget.onScrollControllerCreated(_scrollController);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScreenWithController(scrollController: _scrollController);
  }
}

class ScrollableProfileScreen extends StatefulWidget {
  final Function(ScrollController?) onScrollControllerCreated;
  
  const ScrollableProfileScreen({
    super.key,
    required this.onScrollControllerCreated,
  });

  @override
  State<ScrollableProfileScreen> createState() => _ScrollableProfileScreenState();
}

class _ScrollableProfileScreenState extends State<ScrollableProfileScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    widget.onScrollControllerCreated(_scrollController);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScreenWithController(scrollController: _scrollController);
  }
}