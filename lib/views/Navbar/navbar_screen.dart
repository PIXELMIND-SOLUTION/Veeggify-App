
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:veegify/helper/storage_helper.dart';
import 'package:veegify/model/user_model.dart';
import 'package:veegify/provider/CartProvider/cart_provider.dart';
import 'package:veegify/views/Cart/cart_screen.dart';
import 'package:veegify/views/Booking/history_screen.dart';
import 'package:veegify/views/home/home_screen.dart';
import 'package:veegify/views/ProfileScreen/profile_screen.dart';
import 'package:veegify/views/Wishlist/wishlist_screen.dart';
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
  User? user;

@override
void initState() {
  super.initState();
  _initialize();
}

Future<void> _initialize() async {
  await _loadUserId();

  // After user is loaded, continue initializing animations or data
  _animationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, 1.0),
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ),
  );

  // You can also safely fetch data that depends on the user ID here
  print("User initialized: ${user?.userId}");
}


    Future<void> _loadUserId() async {
    final userData = UserPreferences.getUser();
    if (userData != null) {
      setState(() {
        user = userData;
      });
      print("UUUUUUUUUUUU${user?.userId.toString()}");
    }
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

  void _handleTabChange(int index, BottomNavbarProvider bottomNavbarProvider) {
    print('Tab changed to index: $index'); // Debug print
    
    // If navigating to cart (index 2), trigger cart loading
    if (index == 2) {
      print('Navigating to cart - triggering loadCart'); // Debug print
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        cartProvider.loadCart(user?.userId.toString());
      });
    }
    
    bottomNavbarProvider.setIndex(index);
    
    if (!_isBottomNavVisible) {
      setState(() {
        _isBottomNavVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);

    final pages = [
      ScrollableHomeScreen(onScrollControllerCreated: _attachScrollController),
      ScrollableFavouriteScreen(
          onScrollControllerCreated: _attachScrollController),
      ScrollableCartScreen(onScrollControllerCreated: _attachScrollController),
      ScrollableHistoryScreen(
          onScrollControllerCreated: _attachScrollController),
      ScrollableProfileScreen(
          onScrollControllerCreated: _attachScrollController),
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
        body: Stack(
          children: [
            // Main content - full height
            IndexedStack(
              index: bottomNavbarProvider.currentIndex,
              children: pages,
            ),
            
            // Transparent cart summary positioned at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: _isBottomNavVisible ? 10 : 20, // Adjust based on navbar visibility
              child: Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  if (cartProvider.items.isEmpty ||
                      bottomNavbarProvider.currentIndex == 2) {
                    return const SizedBox.shrink();
                  }
              
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      // Semi-transparent background with blur effect
                      color: Colors.green.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 2),
                          blurRadius: 8,
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
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
              
                        // Checkout Button
                        GestureDetector(
                          onTap: () {
                            _handleTabChange(2, bottomNavbarProvider); // Navigate to cart
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
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
                  );
                },
              ),
            ),
          ],
        ),
        
        // Bottom Navigation Bar - remains opaque
        bottomNavigationBar: _isBottomNavVisible
            ? Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(0, -1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  currentIndex: bottomNavbarProvider.currentIndex,
                  onTap: (index) {
                    _handleTabChange(index, bottomNavbarProvider);
                  },
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,
                  elevation: 0,
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
                      label: 'Account',
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}

// Enhanced ScrollableCartScreen that listens for tab changes
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
  State<ScrollableFavouriteScreen> createState() =>
      _ScrollableFavouriteScreenState();
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
    return WishlistScreen();
  }
}

class ScrollableHistoryScreen extends StatefulWidget {
  final Function(ScrollController?) onScrollControllerCreated;

  const ScrollableHistoryScreen({
    super.key,
    required this.onScrollControllerCreated,
  });

  @override
  State<ScrollableHistoryScreen> createState() =>
      _ScrollableHistoryScreenState();
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
    return HystoryScreenWithController(scrollController: _scrollController);
  }
}

class ScrollableProfileScreen extends StatefulWidget {
  final Function(ScrollController?) onScrollControllerCreated;

  const ScrollableProfileScreen({
    super.key,
    required this.onScrollControllerCreated,
  });

  @override
  State<ScrollableProfileScreen> createState() =>
      _ScrollableProfileScreenState();
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