

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:veegify/provider/cart_provider.dart';
// // Import your cart_provider.dart file here

// class RestaurantDetailScreen extends StatelessWidget {
//   const RestaurantDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> dummyVegDishes = [
//       {
//         'id': '1',
//         'title': 'Veg Panner Fried Rice',
//         'price': 250,
//         'rating': 4.2,
//         'reviews': 2941,
//         'image':
//             'https://www.whiskaffair.com/wp-content/uploads/2018/11/Vegetable-Fried-Rice-2-3.jpg',
//         'isVeg': true,
//       },
//       {
//         'id': '2',
//         'title': 'Paneer Butter Masala',
//         'price': 280,
//         'rating': 4.3,
//         'reviews': 1845,
//         'image':
//             'https://www.whiskaffair.com/wp-content/uploads/2018/11/Vegetable-Fried-Rice-2-3.jpg',
//         'isVeg': true,
//       },
//       {
//         'id': '3',
//         'title': 'Mushroom Pasta',
//         'price': 260,
//         'rating': 4.4,
//         'reviews': 1108,
//         'image':
//             'https://www.whiskaffair.com/wp-content/uploads/2018/11/Vegetable-Fried-Rice-2-3.jpg',
//         'isVeg': true,
//       },
//       {
//         'id': '4',
//         'title': 'Veggie Supreme Pizza',
//         'price': 320,
//         'rating': 4.5,
//         'reviews': 2134,
//         'image':
//             'https://www.whiskaffair.com/wp-content/uploads/2018/11/Vegetable-Fried-Rice-2-3.jpg',
//         'isVeg': true,
//       },
//       {
//         'id': '5',
//         'title': 'Aloo Paratha with Curd',
//         'price': 150,
//         'rating': 4.1,
//         'reviews': 905,
//         'image':
//             'https://www.whiskaffair.com/wp-content/uploads/2018/11/Vegetable-Fried-Rice-2-3.jpg',
//         'isVeg': true,
//       },
//       {
//         'id': '6',
//         'title': 'Vegetable Manchurian',
//         'price': 240,
//         'rating': 4.2,
//         'reviews': 1350,
//         'image':
//             'https://www.whiskaffair.com/wp-content/uploads/2018/11/Vegetable-Fried-Rice-2-3.jpg',
//         'isVeg': true,
//       },
//     ];

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         top: false,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Top Info Section
//               Container(
//                 padding: const EdgeInsets.only(
//                   top: 50,
//                   bottom: 12,
//                   left: 12,
//                   right: 12,
//                 ),
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFEBF4F1),
//                   borderRadius: BorderRadius.vertical(
//                     bottom: Radius.circular(30),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back_ios),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                         const Spacer(),
//                         const Column(
//                           children: [
//                             Icon(Icons.location_pin,
//                                 size: 30, color: Colors.grey),
//                             Text("Kakinada", style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Stack(
//                       children: [
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: const Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Burger king –",
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                               Text("SRMT Mall",
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                               SizedBox(height: 8),
//                               Row(children: [
//                                 Icon(Icons.timer, size: 16),
//                                 SizedBox(width: 4),
//                                 Text("25–30 min - 2.4 km")
//                               ]),
//                               SizedBox(height: 4),
//                               Row(children: [
//                                 Icon(Icons.location_on_outlined, size: 16),
//                                 SizedBox(width: 4),
//                                 Text("Kakinada")
//                               ]),
//                               SizedBox(height: 4),
//                               Text("Burgers, Fries",
//                                   style: TextStyle(color: Colors.grey)),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           top: 10,
//                           right: 20,
//                           child: Column(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 14, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   color: Colors.green,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: const Row(
//                                   children: [
//                                     Icon(Icons.star,
//                                         color: Colors.white, size: 16),
//                                     SizedBox(width: 4),
//                                     Text("4.2",
//                                         style: TextStyle(color: Colors.white)),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               const Text("14k+ ratings",
//                                   style: TextStyle(
//                                       color: Colors.grey, fontSize: 10)),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // Search Bar
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           hintText: 'Search your food',
//                           prefixIcon: const Icon(Icons.search),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     const CircleAvatar(
//                       backgroundColor: Colors.green,
//                       radius: 25,
//                       child: Icon(Icons.tune, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),

//               const Divider(height: 30),

//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Recommended',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),

//               // Dishes List
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: dummyVegDishes.length,
//                 itemBuilder: (context, index) {
//                   final dish = dummyVegDishes[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Row(
//                         children: [
//                           // Left: Dish Info
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(5),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.green),
//                                   ),
//                                   child: Icon(
//                                     Icons.circle,
//                                     size: 12,
//                                     color: dish['isVeg']
//                                         ? Colors.green
//                                         : Colors.red,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Text(dish['title'],
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold)),
//                                 const SizedBox(height: 6),
//                                 Text("₹${dish['price']}",
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold)),
//                                 const SizedBox(height: 6),
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.star,
//                                         size: 16, color: Colors.green),
//                                     const SizedBox(width: 4),
//                                     Text("${dish['rating']}"),
//                                     const SizedBox(width: 4),
//                                     Text("(${dish['reviews']})",
//                                         style: const TextStyle(
//                                             color: Colors.grey)),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 6),
//                                 const Text(
//                                     "Deliciously decadent flavored dum rice l...",
//                                     style: TextStyle(color: Colors.grey)),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 10),

//                           // Right: Image and Add Button
//                           SizedBox(
//                             width: 150,
//                             child: Column(
//                               children: [
//                                 Stack(
//                                   clipBehavior: Clip.none,
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Image.network(
//                                         dish['image'],
//                                         width: 150,
//                                         height: 150,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     const Positioned(
//                                       top: 4,
//                                       right: 4,
//                                       child: CircleAvatar(
//                                         backgroundColor: Colors.white,
//                                         radius: 14,
//                                         child: Icon(Icons.favorite_border,
//                                             size: 18),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       left: 35,
//                                       bottom: -20,
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           showModalBottomSheet(
//                                             context: context,
//                                             isScrollControlled: true,
//                                             shape: const RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.vertical(
//                                                       top: Radius.circular(25)),
//                                             ),
//                                             builder: (context) =>
//                                                 VegPannerBottomSheet(
//                                                     dish: dish),
//                                           );
//                                         },
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 20, vertical: 10),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             border: Border.all(
//                                                 color: const Color(0xFFB0C0B0),
//                                                 width: 1.5),
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.black
//                                                     .withOpacity(0.1),
//                                                 blurRadius: 8,
//                                                 spreadRadius: 2,
//                                                 offset: const Offset(0, 4),
//                                               ),
//                                             ],
//                                           ),
//                                           child: const Text(
//                                             'ADD',
//                                             style: TextStyle(
//                                                 color: Colors.green,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 25),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class VegPannerBottomSheet extends StatefulWidget {
//   final Map<String, dynamic> dish;

//   const VegPannerBottomSheet({super.key, required this.dish});

//   @override
//   _VegPannerBottomSheetState createState() => _VegPannerBottomSheetState();
// }

// class _VegPannerBottomSheetState extends State<VegPannerBottomSheet> {
//   String selectedVariation = 'Half';
//   Set<String> selectedAddOns = {};
//   int quantity = 1;

//   int getPrice() {
//     int base = selectedVariation == 'Half' ? 225 : 310;
//     int addOn = 0;
//     if (selectedAddOns.contains('1 Plate')) addOn += 5;
//     if (selectedAddOns.contains('2 Plates')) addOn += 10;
//     return (base + addOn) * quantity;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: SizedBox(
//                 height: 40,
//                 width: 40,
//                 child: Image.network(widget.dish['image'])),
//             title: Text(
//               widget.dish['title'],
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             trailing: IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(12),
//             decoration: BoxDecoration(color: Color(0XFFEBF4F1)),
//             child: Column(
//               children: [
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text('Variation',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                 ),
//                 Align(
//                     alignment: Alignment.centerLeft,
//                     child: const Text('Select any 1')),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.white),
//                     child: Column(
//                       children: [
//                         ListTile(
//                           title: const Text('Half'),
//                           trailing: const Text('₹225'),
//                           leading: Radio<String>(
//                             value: 'Half',
//                             groupValue: selectedVariation,
//                             onChanged: (val) =>
//                                 setState(() => selectedVariation = val!),
//                           ),
//                         ),
//                         ListTile(
//                           title: const Text('Full'),
//                           trailing: const Text('₹310'),
//                           leading: Radio<String>(
//                             value: 'Full',
//                             groupValue: selectedVariation,
//                             onChanged: (val) =>
//                                 setState(() => selectedVariation = val!),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text('Add on plate',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                 ),
//                 Align(
//                     alignment: Alignment.centerLeft,
//                     child: const Text('Select up to 2')),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.white),
//                     child: Column(
//                       children: [
//                         CheckboxListTile(
//                           title: const Text('1 Plate'),
//                           secondary: const Text('+₹5'),
//                           value: selectedAddOns.contains('1 Plate'),
//                           onChanged: (val) {
//                             setState(() {
//                               if (val == true) {
//                                 selectedAddOns.add('1 Plate');
//                               } else {
//                                 selectedAddOns.remove('1 Plate');
//                               }
//                             });
//                           },
//                         ),
//                         CheckboxListTile(
//                           title: const Text('2 Plates'),
//                           secondary: const Text('+₹10'),
//                           value: selectedAddOns.contains('2 Plates'),
//                           onChanged: (val) {
//                             setState(() {
//                               if (val == true) {
//                                 selectedAddOns.add('2 Plates');
//                               } else {
//                                 selectedAddOns.remove('2 Plates');
//                               }
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Quantity selector
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.shade400),
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: quantity > 1
//                             ? () => setState(() => quantity--)
//                             : null,
//                         icon: const Icon(Icons.remove),
//                       ),
//                       Text('$quantity'),
//                       IconButton(
//                         onPressed: () => setState(() => quantity++),
//                         icon: const Icon(Icons.add),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape: const StadiumBorder(),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 12),
//                   ),
//                   onPressed: () {
//                     // Add item to cart
//                     final cartItem = CartItem(
//                       id: '${widget.dish['id']}_${DateTime.now().millisecondsSinceEpoch}',
//                       title: widget.dish['title'],
//                       image: widget.dish['image'],
//                       basePrice: widget.dish['price'],
//                       variation: selectedVariation,
//                       addOns: Set.from(selectedAddOns),
//                       quantity: quantity,
//                       isVeg: widget.dish['isVeg'],
//                     );

//                     Provider.of<CartProvider>(context, listen: false)
//                         .addItem(cartItem);

//                     Navigator.pop(context);

//                     // Show success message
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('${widget.dish['title']} added to cart!'),
//                         backgroundColor: Colors.green,
//                         duration: const Duration(seconds: 2),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'Add Item | ₹${getPrice()}',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
// }












import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/model/restaurant_product_model.dart';
import 'package:veegify/provider/cart_provider.dart';
import 'package:veegify/provider/restaurant_products_provider.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantProductsProvider>(context, listen: false)
          .fetchRestaurantProducts(widget.restaurantId);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                    Icon(Icons.error_outline, size: 64, color: Colors.red),
                    SizedBox(height: 16),
                    Text(
                      'Error: ${restaurantProvider.error}',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        restaurantProvider.fetchRestaurantProducts(widget.restaurantId);
                      },
                      child: Text('Retry'),
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
                            const Spacer(),
                            const Column(
                              children: [
                                Icon(Icons.location_pin,
                                    size: 30, color: Colors.grey),
                                Text("Kakinada", style: TextStyle(fontSize: 12)),
                              ],
                            ),
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.timer, size: 16),
                                      const SizedBox(width: 4),
                                      Text(restaurantProvider.timeAndDistance != null 
                                          ? "${restaurantProvider.timeAndDistance!.time} - ${restaurantProvider.timeAndDistance!.distance}"
                                          : "25–30 min - 2.4 km"),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Row(
                                    children: [
                                      Icon(Icons.location_on_outlined, size: 16),
                                      SizedBox(width: 4),
                                      Text("Kakinada"),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Text("Food, Specialties",
                                      style: TextStyle(color: Colors.grey)),
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
                                  const Text("14k+ ratings",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10)),
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
                        const SizedBox(width: 10),
                        const CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 25,
                          child: Icon(Icons.tune, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 30),

                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recommended',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
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
                            final item = recommendedItems[index];
                            final product = restaurantProvider.products.firstWhere(
                              (p) => p.recommended.contains(item),
                            );
                            
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
                                            child: const Icon(
                                              Icons.circle,
                                              size: 12,
                                              color: Colors.green, // Assuming all items are veg for now
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
                                              const Positioned(
                                                top: 4,
                                                right: 4,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 14,
                                                  child: Icon(Icons.favorite_border,
                                                      size: 18),
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
                                                        item: item,
                                                        product: product,
                                                      ),
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class VegPannerBottomSheet extends StatefulWidget {
  final RecommendedItem item;
  final RestaurantProduct product;

  const VegPannerBottomSheet({
    super.key,
    required this.item,
    required this.product,
  });

  @override
  _VegPannerBottomSheetState createState() => _VegPannerBottomSheetState();
}

class _VegPannerBottomSheetState extends State<VegPannerBottomSheet> {
  String selectedVariation = 'Half';
  Set<String> selectedAddOns = {};
  int quantity = 1;

  num getPrice() {
    // Use the variation price from the API
    num basePrice = selectedVariation == 'Half' 
        ? widget.product.addons.variation.price 
        : (widget.product.addons.variation.price * 1.5).round(); // Assuming full is 1.5x half
    
    num addOnPrice = 0;
    
    // Calculate addon price based on plates
    if (selectedAddOns.contains('1 Plate')) {
      addOnPrice += widget.product.addons.plates.platePrice ?? 5;
    }
    if (selectedAddOns.contains('2 Plates')) {
      addOnPrice += (widget.product.addons.plates.platePrice ?? 5) * 2;
    }
    
    return (basePrice + addOnPrice) * quantity;
  }

  @override
  void initState() {
    super.initState();
    selectedVariation = widget.product.addons.variation.type;
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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Variation',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                      children: [
                        ListTile(
                          title: const Text('Half'),
                          trailing: Text('₹${widget.product.addons.variation.price}'),
                          leading: Radio<String>(
                            value: 'Half',
                            groupValue: selectedVariation,
                            onChanged: (val) =>
                                setState(() => selectedVariation = val!),
                          ),
                        ),
                        ListTile(
                          title: const Text('Full'),
                          trailing: Text('₹${(widget.product.addons.variation.price * 1.5).round()}'),
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
                  child: Text(
                    'Add on plate',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Select up to 2'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: const Text('1 Plate'),
                          secondary: Text('+₹${widget.product.addons.plates.platePrice ?? 5}'),
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
                          secondary: Text('+₹${(widget.product.addons.plates.platePrice ?? 5) * 2}'),
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
                      id: '${widget.item.id}_${DateTime.now().millisecondsSinceEpoch}',
                      title: widget.item.name,
                      image: widget.item.image,
                      basePrice: widget.item.price,
                      variation: selectedVariation,
                      addOns: Set.from(selectedAddOns),
                      quantity: quantity,
                      isVeg: true, // Assuming all items are veg from API data
                    );

                    Provider.of<CartProvider>(context, listen: false)
                        .addItem(cartItem);

                    Navigator.pop(context);

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${widget.item.name} added to cart!'),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text(
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
  }
}