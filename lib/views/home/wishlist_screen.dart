

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/helper/storage_helper.dart';
import 'package:veegify/model/product_model.dart';
import 'package:veegify/provider/cart_provider.dart';
import 'package:veegify/provider/wishlist_provider.dart';
import 'package:veegify/views/home/navbar_screen.dart';
import 'package:veegify/widgets/bottom_navbar.dart';

class FavouriteScreenWithController extends StatefulWidget {
  final ScrollController scrollController;
  
  const FavouriteScreenWithController({
    super.key,
    required this.scrollController,
  });

  @override
  State<FavouriteScreenWithController> createState() => _FavouriteScreenWithControllerState();
}

class _FavouriteScreenWithControllerState extends State<FavouriteScreenWithController> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    // Load wishlist data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WishlistProvider>().loadWishlist(userId.toString());
    });
  }

  Future<void> _loadUserId() async {
    final user = UserPreferences.getUser();
    if (user != null && mounted) {
      setState(() {
        userId = user.userId;
      });
    }
  }

  void _handleBackButton() {
    // Navigate to NavbarScreen with home tab (index 0) and clear the stack
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const NavbarScreen(),
      ),
      (route) => false,
    );
    
    // Set the bottom navigation to home tab
    Provider.of<BottomNavbarProvider>(context, listen: false).setIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header - not scrollable
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _handleBackButton,
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const SizedBox(width: 30),
                  const Text(
                    'Favourites',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                  const Spacer(),
                  // Show wishlist count
                  Consumer<WishlistProvider>(
                    builder: (context, wishlistProvider, child) {
                      return Text(
                        '(${wishlistProvider.wishlistCount})',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: Consumer<WishlistProvider>(
                builder: (context, wishlistProvider, child) {
                  // Loading State
                  if (wishlistProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // Error State
                  if (wishlistProvider.error.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error loading favourites',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            wishlistProvider.error,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              wishlistProvider.clearError();
                              wishlistProvider.loadWishlist(userId.toString());
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  // Empty State
                  if (wishlistProvider.wishlistItems.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No favourites yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Start adding items to your favourites!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Wishlist Items with Scroll Controller
                  return RefreshIndicator(
                    onRefresh: () async {
                      await wishlistProvider.loadWishlist(userId.toString());
                    },
                    child: ListView.builder(
                      controller: widget.scrollController, // Use the provided scroll controller
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: wishlistProvider.wishlistItems.length,
                      itemBuilder: (context, index) {
                        final product = wishlistProvider.wishlistItems[index];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Left: Dish Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.green),
                                        ),
                                        child: Icon(
                                          Icons.circle,
                                          size: 12,
                                          color: product.isVeg
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(product.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 6),
                                      Text("₹${product.price}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(Icons.star,
                                              size: 16, color: Colors.green),
                                          const SizedBox(width: 4),
                                          Text("${product.rating}"),
                                          const SizedBox(width: 4),
                                          Text("(${product.reviews.length})",
                                              style: const TextStyle(
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      const Text(
                                          "Deliciously decadent flavored dum rice l...",
                                          style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),

                                // Right: Image and Add Button
                                SizedBox(
                                  width: 150,
                                  child: Column(
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              product.image,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            right: 4,
                                            top: 4,
                                            child: GestureDetector(
                                              onTap: () async {
                                                await wishlistProvider
                                                    .removeFromWishlist(
                                                  userId.toString(),
                                                  product.id,
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        '${product.name} removed from favourites'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              },
                                              child: const CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.favorite,
                                                  size: 16,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 35,
                                            bottom: -20,
                                            child: GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top: Radius.circular(25)),
                                                  ),
                                                  builder: (context) =>
                                                      VegPannerBottomSheet(
                                                          product: product),
                                                );
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: const Color(0xFFB0C0B0),
                                                      width: 1.5),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      blurRadius: 8,
                                                      spreadRadius: 2,
                                                      offset: const Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: const Text(
                                                  'ADD',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 25),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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

// Keep the original FavouriteScreen for backward compatibility
class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({
    super.key,
  });

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
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

class VegPannerBottomSheet extends StatefulWidget {
  final Product product;

  const VegPannerBottomSheet({super.key, required this.product});

  @override
  _VegPannerBottomSheetState createState() => _VegPannerBottomSheetState();
}

class _VegPannerBottomSheetState extends State<VegPannerBottomSheet> {
  String selectedVariation = 'Half';
  Set<String> selectedAddOns = {};
  int quantity = 1;

  int getPrice() {
    int base = selectedVariation == 'Half' ? 225 : 310;
    int addOn = 0;
    if (selectedAddOns.contains('1 Plate')) addOn += 5;
    if (selectedAddOns.contains('2 Plates')) addOn += 10;
    return (base + addOn) * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: SizedBox(
                height: 40,
                width: 40,
                child: Image.network(widget.product.image)),
            title: Text(
              widget.product.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Color(0XFFEBF4F1)),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Variation',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: const Text('Select any 1')),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Half'),
                          trailing: const Text('₹225'),
                          leading: Radio<String>(
                            value: 'Half',
                            groupValue: selectedVariation,
                            onChanged: (val) =>
                                setState(() => selectedVariation = val!),
                          ),
                        ),
                        ListTile(
                          title: const Text('Full'),
                          trailing: const Text('₹310'),
                          leading: Radio<String>(
                            value: 'Full',
                            groupValue: selectedVariation,
                            onChanged: (val) =>
                                setState(() => selectedVariation = val!),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Add on plate',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: const Text('Select up to 2')),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: const Text('1 Plate'),
                          secondary: const Text('+₹5'),
                          value: selectedAddOns.contains('1 Plate'),
                          onChanged: (val) {
                            setState(() {
                              if (val == true) {
                                selectedAddOns.add('1 Plate');
                              } else {
                                selectedAddOns.remove('1 Plate');
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text('2 Plates'),
                          secondary: const Text('+₹10'),
                          value: selectedAddOns.contains('2 Plates'),
                          onChanged: (val) {
                            setState(() {
                              if (val == true) {
                                selectedAddOns.add('2 Plates');
                              } else {
                                selectedAddOns.remove('2 Plates');
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Quantity selector
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: quantity > 1
                            ? () => setState(() => quantity--)
                            : null,
                        icon: const Icon(Icons.remove),
                      ),
                      Text('$quantity'),
                      IconButton(
                        onPressed: () => setState(() => quantity++),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    // Add item to cart
                    final cartItem = CartItem(
                      id: '${widget.product.id}_${DateTime.now().millisecondsSinceEpoch}',
                      title: widget.product.contentName,
                      image: widget.product.image,
                      basePrice: 199,
                      variation: selectedVariation,
                      addOns: Set.from(selectedAddOns),
                      quantity: quantity,
                      isVeg: widget.product.isVeg,
                    );

                    Provider.of<CartProvider>(context, listen: false)
                        .addItem(cartItem);

                    Navigator.pop(context);

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${widget.product.contentName} added to cart!'),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text(
                    'Add Item | ₹${getPrice()}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}