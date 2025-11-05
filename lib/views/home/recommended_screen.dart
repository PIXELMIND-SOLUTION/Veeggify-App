
// Updated restaurant_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/helper/storage_helper.dart';
import 'package:veegify/model/restaurant_product_model.dart' hide CartItem;
import 'package:veegify/provider/CartProvider/cart_provider.dart';
import 'package:veegify/provider/RestaurantProvider/restaurant_products_provider.dart';
import 'package:veegify/provider/WishListProvider/wishlist_provider.dart';
import 'package:veegify/views/Cart/cart_screen.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantId;
  
  const RestaurantDetailScreen({
    super.key, 
    required this.restaurantId,
  });

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
    String? userId;


  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await _initializeData();
                await context.read<WishlistProvider>().fetchWishlist(userId.toString());

  });
}

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

Future<void> _initializeData() async {
  try {
    // Example: Fetch userId from shared preferences
    _loadUserId();

    if (userId == null) {
      print("User ID not found!");
      return;
    }

    // Then fetch restaurant products
    await Provider.of<RestaurantProductsProvider>(context, listen: false)
        .fetchRestaurantProducts(widget.restaurantId);

    // Then load cart using that userId
    await Provider.of<CartProvider>(context, listen: false).loadCart(userId);

    print("Data initialized successfully ✅");
  } catch (e, stack) {
    print("Error initializing data: $e\n$stack");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Consumer<RestaurantProductsProvider>(
          builder: (context, restaurantProvider, child) {
            if (restaurantProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            }

            if (restaurantProvider.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${restaurantProvider.error}',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        restaurantProvider.fetchRestaurantProducts(widget.restaurantId);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final recommendedItems = _searchQuery.isEmpty 
                ? restaurantProvider.allRecommendedItems
                : restaurantProvider.searchItems(_searchQuery);

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Top Info Section
                  Container(
                    padding: const EdgeInsets.only(
                      top: 50,
                      bottom: 12,
                      left: 12,
                      right: 12,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEBF4F1),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () => Navigator.pop(context),
                            ),
                            // const Spacer(),
                            // const Column(
                            //   children: [
                            //     Icon(Icons.location_pin,
                            //         size: 30, color: Colors.grey),
                            //     Text("Kakinada", style: TextStyle(fontSize: 12)),
                            //   ],
                            // ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurantProvider.restaurantName.isNotEmpty 
                                        ? restaurantProvider.restaurantName 
                                        : "Restaurant",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    restaurantProvider.locationName.isNotEmpty 
                                        ? restaurantProvider.locationName 
                                        : "Location",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  const Row(
                                    children: [
                                      Icon(Icons.timer, size: 16),
                                      SizedBox(width: 4),
                                      Text("25–30 min - 2.4 km"),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined, size: 16),
                                      const SizedBox(width: 4),
                                      Text(restaurantProvider.locationName.isNotEmpty 
                                          ? restaurantProvider.locationName 
                                          : "Location"),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    restaurantProvider.recommendedProducts.isNotEmpty
                                        ? restaurantProvider.recommendedProducts.first.type.join(", ")
                                        : "Food, Specialties",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 20,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.white, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          restaurantProvider.rating > 0 
                                              ? restaurantProvider.rating.toString() 
                                              : "4.2",
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${restaurantProvider.recommendedProducts.isNotEmpty ? restaurantProvider.recommendedProducts.first.viewCount : '14k'}+ ratings",
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search your food',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                          ),
                        ),
                        // const SizedBox(width: 10),
                        // const CircleAvatar(
                        //   backgroundColor: Colors.green,
                        //   radius: 25,
                        //   child: Icon(Icons.tune, color: Colors.white),
                        // ),
                      ],
                    ),
                  ),

                  const Divider(height: 30),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recommended',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${restaurantProvider.totalRecommendedItems} items',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  // Dishes List
                  recommendedItems.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              Icon(Icons.search_off, size: 64, color: Colors.grey),
                              SizedBox(height: 16),
                              Text(
                                'No items found',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recommendedItems.length,
                          itemBuilder: (context, index) {
                            final itemWithId = recommendedItems[index];
                            final item = itemWithId.recommendedItem;
                            final productId = itemWithId.productId;
                            final product = restaurantProvider.getProductByRecommendedItem(item);
                            
                            return Consumer<CartProvider>(
                              builder: (context, cartProvider, child) {
                                // Use productId instead of item.id
                                final cartItem = cartProvider.getCartProduct(productId);
                                final isInCart = cartItem != null;
                                final cartQuantity = cartItem?.quantity ?? 0;

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
                                                  color: product?.type.contains('Veg') == true 
                                                      ? Colors.green 
                                                      : Colors.green,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                item.name,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                "₹${item.price}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  const Icon(Icons.star,
                                                      size: 16, color: Colors.green),
                                                  const SizedBox(width: 4),
                                                  Text("${item.rating}"),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    "(${item.viewCount})",
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                item.content.isNotEmpty 
                                                    ? item.content 
                                                    : "Delicious food item",
                                                style: const TextStyle(color: Colors.grey),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  item.category.categoryName,
                                                  style: const TextStyle(
                                                      fontSize: 10, color: Colors.grey),
                                                ),
                                              ),
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
              item.image,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 40,
                  ),
                );
              },
            ),
          ),

          // ✅ Replace static icon with Consumer
          Consumer<WishlistProvider>(
            builder: (context, wishlistProvider, child) {
              print("Pooooooooooooooooooooooooooooo$productId");

              final isInWishlist = wishlistProvider.isInWishlist(productId);
print("ooooooooooooooooooooooooooooo$isInWishlist");
              return Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () async {
                    await wishlistProvider.toggleWishlist(userId.toString(), productId);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 14,
                    child: Icon(
                      isInWishlist ? Icons.favorite : Icons.favorite_border,
                      color: isInWishlist ? Colors.red : Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
              );
            },
          ),

          // ✅ Your existing Cart UI (unchanged)
          Positioned(
            left: 35,
            bottom: -20,
            child: isInCart
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 16,
                          ),
                          onPressed: cartProvider.isLoading
                              ? null
                              : () async {
                                  if (cartQuantity > 1) {
                                    // await cartProvider.updateItemQuantity(
                                    //   cartProductId: productId,
                                    //   newQuantity: cartQuantity - 1,
                                    // );
                                  } else {
                                    await cartProvider.removeItem(productId);
                                  }
                                },
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            cartQuantity.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                          onPressed: cartProvider.isLoading
                              ? null
                              : () async {
                                  // await cartProvider.updateItemQuantity(
                                  //   cartProductId: productId,
                                  //   newQuantity: cartQuantity + 1,
                                  // );
                                },
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: cartProvider.isLoading
                        ? null
                        : () {
                            if (product != null) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25)),
                                ),
                                builder: (context) => VegPannerBottomSheet(
                                  item: item,
                                  product: product,
                                  productId: productId,
                                  restaurantId: widget.restaurantId,
                                  userId: userId.toString()
                                ),
                              );
                            }
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color(0xFFB0C0B0), width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
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
)

                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                  
                  const SizedBox(height: 100), // Space for potential bottom navigation
                ],
              ),
            );
          },
        ),
      ),
      
      // Floating Action Button for Cart
      floatingActionButton: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (!cartProvider.hasItems) {
            return const SizedBox.shrink();
          }
          
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: FloatingActionButton.extended(
              onPressed: () {
                // Navigate to cart screen
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CartScreen()));
              },
              backgroundColor: Colors.green,
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${cartProvider.totalItems} items | ₹${cartProvider.totalPayable}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'View Cart',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class VegPannerBottomSheet extends StatefulWidget {
  final RecommendedItem item;
  final RecommendedProduct product;
  final String productId; // Add productId parameter
  final String restaurantId;
  final String userId;

  const VegPannerBottomSheet({
    super.key,
    required this.item,
    required this.product,
    required this.productId, // Make productId required
    required this.restaurantId,
    required this.userId
  });

  @override
  _VegPannerBottomSheetState createState() => _VegPannerBottomSheetState();
}

class _VegPannerBottomSheetState extends State<VegPannerBottomSheet> {
  String selectedVariation = '';
  int selectedPlateItems = 0;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    // Set default variation from API data
    if (widget.item.addons.variation.type.isNotEmpty) {
      selectedVariation = widget.item.addons.variation.type.first;
    } else {
      selectedVariation = 'Half';
    }
  }

  num getPrice() {
    num basePrice = widget.item.price;
    
    // Apply variation pricing based on vendor percentage
    if (selectedVariation == 'Full') {
      double fullMultiplier = (100 + widget.item.vendorHalfPercentage) / 100;
      basePrice = (widget.item.price * fullMultiplier).round();
    }
    
    // Calculate addon price using vendor plate cost
    num addOnPrice = selectedPlateItems * widget.item.vendorPlateCost;
    
    return (basePrice + addOnPrice) * quantity;
  }

  @override
  Widget build(BuildContext context) {
    final hasVariations = widget.item.addons.variation.type.isNotEmpty;
    final hasPlates = widget.item.addons.plates.name.isNotEmpty;

    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: SizedBox(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.item.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.image_not_supported),
                        );
                      },
                    ),
                  ),
                ),
                title: Text(
                  widget.item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(color: Color(0XFFEBF4F1)),
                child: Column(
                  children: [
                    // Variations Section
                    if (hasVariations) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.item.addons.variation.name.isNotEmpty 
                              ? widget.item.addons.variation.name 
                              : 'Variation',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Select any 1'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: widget.item.addons.variation.type.map((variation) {
                              // Calculate price based on variation
                              num price = widget.item.price;
                              if (variation == 'Full') {
                                double fullMultiplier = (100 + widget.item.vendorHalfPercentage) / 100;
                                price = (widget.item.price * fullMultiplier).round();
                              }
                              
                              return ListTile(
                                title: Text(variation),
                                trailing: Text('₹$price'),
                                leading: Radio<String>(
                                  value: variation,
                                  groupValue: selectedVariation,
                                  onChanged: (val) =>
                                      setState(() => selectedVariation = val!),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                    
                    // Add-on plates section
                    if (hasPlates) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.item.addons.plates.name.isNotEmpty 
                              ? widget.item.addons.plates.name 
                              : 'Add on plate',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Select quantity'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [0, 1, 2].map((plateCount) {
                              return ListTile(
                                title: Text(plateCount == 0 
                                    ? 'No Plates' 
                                    : '$plateCount Plate${plateCount > 1 ? 's' : ''}'),
                                trailing: plateCount > 0 
                                    ? Text('+₹${widget.item.vendorPlateCost * plateCount}')
                                    : const Text('₹0'),
                                leading: Radio<int>(
                                  value: plateCount,
                                  groupValue: selectedPlateItems,
                                  onChanged: (val) =>
                                      setState(() => selectedPlateItems = val!),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                    
                    // If no variations or plates available
                    if (!hasVariations && !hasPlates) ...[
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'No customization options available for this item.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
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
                      onPressed: cartProvider.isLoading 
                          ? null 
                          : () async {
                        // Add item to cart using productId instead of product.id
                        final success = await cartProvider.addItemToCart(
                          restaurantProductId: widget.productId, // Use productId from widget
                          recommendedId: widget.item.itemId, // Or use appropriate identifier
                          quantity: quantity,
                          variation: selectedVariation,
                          plateItems: selectedPlateItems,
                          userId: widget.userId.toString()
                        );    

                        if (success) {
                          Navigator.pop(context);
                          
                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${widget.item.name} added to cart!'),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        } else {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(cartProvider.error ?? 'Failed to add item to cart'),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: cartProvider.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Add Item | ₹${getPrice()}',
                              style: const TextStyle(color: Colors.white),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}