





// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:veegify/provider/cart_provider.dart';
// import 'package:veegify/views/home/payment_success_screen.dart';
// // Import your cart_provider.dart file here

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Consumer<CartProvider>(
//           builder: (context, cartProvider, child) {
//             if (cartProvider.items.isEmpty) {
//               return const EmptyCartWidget();
//             }

//             return Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 25,
//                         backgroundColor: Color.fromARGB(255, 224, 244, 242),
//                         child: Icon(Icons.shopping_cart, color: Colors.black),
//                       ),
//                       SizedBox(width: 20),
//                       Text(
//                         'My Cart',
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),

//                   // Cart List
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: cartProvider.items.length,
//                       itemBuilder: (context, index) => CartItemWidget(
//                         cartItem: cartProvider.items[index],
//                         onQuantityChanged: (newQuantity) {
//                           cartProvider.updateQuantity(
//                             cartProvider.items[index].id,
//                             newQuantity,
//                           );
//                         },
//                         onRemove: () {
//                           cartProvider.removeItem(cartProvider.items[index].id);
//                         },
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 10),

//                   // Coupon Field
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Enter Coupon Code',
//                             filled: true,
//                             fillColor: Colors.grey.shade200,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Icon(Icons.arrow_forward, color: Colors.white),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // Pricing Summary
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       children: [
//                         RowItem(
//                           label: 'Total Items',
//                           value: '${cartProvider.totalItems.toString().padLeft(2, '0')}',
//                         ),
//                         RowItem(
//                           label: 'Sub Total',
//                           value: '₹${cartProvider.subtotal}.00',
//                         ),
//                         RowItem(
//                           label: 'Delivery charge',
//                           value: '₹${cartProvider.deliveryCharge}.00',
//                         ),
//                         const Divider(),
//                         RowItem(
//                           label: 'Total Payable',
//                           value: '₹${cartProvider.totalPayable}.00',
//                           valueColor: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Checkout Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Navigate to checkout
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>const PaymentSuccessScreen()));
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Proceeding to checkout...'),
//                             backgroundColor: Colors.green,
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         'Checkout',
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // Empty cart widget
// class EmptyCartWidget extends StatelessWidget {
//   const EmptyCartWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.shopping_cart_outlined,
//             size: 100,
//             color: Colors.grey.shade400,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'Your cart is empty',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey.shade600,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             'Add some delicious items to your cart',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey.shade500,
//             ),
//           ),
//           const SizedBox(height: 30),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context); // Go back to previous screen
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green,
//               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               'Start Shopping',
//               style: TextStyle(fontSize: 16, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Cart Item Widget
// class CartItemWidget extends StatelessWidget {
//   final CartItem cartItem;
//   final Function(int) onQuantityChanged;
//   final VoidCallback onRemove;

//   const CartItemWidget({
//     super.key,
//     required this.cartItem,
//     required this.onQuantityChanged,
//     required this.onRemove,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       child: Row(
//         children: [
//           // Dish Image
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.network(
//               cartItem.image ?? '',
//               width: 60,
//               height: 60,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => Icon(
//                 Icons.image,
//                 size: 40,
//                 color: Colors.grey.shade400,
//               ),
//             ),
//           ),

//           const SizedBox(width: 12),

//           // Dish Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   cartItem.title,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Qty: ${cartItem.variation}',
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Quantity Controls
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   if (cartItem.quantity > 1) {
//                     onQuantityChanged(cartItem.quantity - 1);
//                   }
//                 },
//                 child: Container(
//                   width: 32,
//                   height: 32,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: cartItem.quantity > 1
//                         ? Colors.green
//                         : Colors.grey.shade300,
//                   ),
//                   child: Icon(
//                     Icons.remove,
//                     size: 18,
//                     color: cartItem.quantity > 1
//                         ? Colors.white
//                         : Colors.grey.shade600,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               SizedBox(
//                 width: 28,
//                 child: Text(
//                   cartItem.quantity.toString().padLeft(2, '0'),
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () => onQuantityChanged(cartItem.quantity + 1),
//                 child: Container(
//                   width: 32,
//                   height: 32,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.green,
//                   ),
//                   child: const Icon(
//                     Icons.add,
//                     size: 18,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(width: 12),

//           // Delete Button
//           GestureDetector(
//             onTap: onRemove,
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.red.shade50,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.delete,
//                 size: 20,
//                 color: Colors.red.shade400,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Row Item Widget for pricing summary
// class RowItem extends StatelessWidget {
//   final String label;
//   final String value;
//   final Color? valueColor;
//   final FontWeight? fontWeight;

//   const RowItem({
//     super.key,
//     required this.label,
//     required this.value,
//     this.valueColor,
//     this.fontWeight,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade700,
//               fontWeight: fontWeight,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 14,
//               color: valueColor ?? Colors.black,
//               fontWeight: fontWeight,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:veegify/provider/cart_provider.dart';
// import 'package:veegify/provider/booking_provider.dart'; // Add this import
// import 'package:veegify/views/category/category_based_screen.dart';
// import 'package:veegify/views/home/payment_success_screen.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Consumer<CartProvider>(
//           builder: (context, cartProvider, child) {
//             if (cartProvider.items.isEmpty) {
//               return const EmptyCartWidget();
//             }

//             return Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 25,
//                         backgroundColor: Color.fromARGB(255, 224, 244, 242),
//                         child: Icon(Icons.shopping_cart, color: Colors.black),
//                       ),
//                       SizedBox(width: 20),
//                       Text(
//                         'My Cart',
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),

//                   // Cart List
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: cartProvider.items.length,
//                       itemBuilder: (context, index) => CartItemWidget(
//                         cartItem: cartProvider.items[index],
//                         onQuantityChanged: (newQuantity) {
//                           cartProvider.updateQuantity(
//                             cartProvider.items[index].id,
//                             newQuantity,
//                           );
//                         },
//                         onRemove: () {
//                           cartProvider.removeItem(cartProvider.items[index].id);
//                         },
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 10),

//                   // Coupon Field
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Enter Coupon Code',
//                             filled: true,
//                             fillColor: Colors.grey.shade200,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Icon(Icons.arrow_forward, color: Colors.white),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // Pricing Summary
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       children: [
//                         RowItem(
//                           label: 'Total Items',
//                           value: '${cartProvider.totalItems.toString().padLeft(2, '0')}',
//                         ),
//                         RowItem(
//                           label: 'Sub Total',
//                           value: '₹${cartProvider.subtotal}.00',
//                         ),
//                         RowItem(
//                           label: 'Delivery charge',
//                           value: '₹${cartProvider.deliveryCharge}.00',
//                         ),
//                         const Divider(),
//                         RowItem(
//                           label: 'Total Payable',
//                           value: '₹${cartProvider.totalPayable}.00',
//                           valueColor: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Checkout Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Add booking to BookingProvider
//                         final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
                        
//                         bookingProvider.addBookingFromCart(
//                           cartItems: cartProvider.items,
//                           subtotal: cartProvider.subtotal,
//                           deliveryCharge: cartProvider.deliveryCharge,
//                           totalPayable: cartProvider.totalPayable,
//                           totalItems: cartProvider.totalItems,
//                         );
                        
//                         // Clear cart after booking
//                         cartProvider.clearCart();
                        
//                         // Navigate to payment success screen
//                         Navigator.push(
//                           context, 
//                           MaterialPageRoute(builder: (context) => const PaymentSuccessScreen())
//                         );
                        
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Booking created successfully!'),
//                             backgroundColor: Colors.green,
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         'Checkout',
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // Empty cart widget
// class EmptyCartWidget extends StatelessWidget {
//   const EmptyCartWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.shopping_cart_outlined,
//             size: 100,
//             color: Colors.grey.shade400,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'Your cart is empty',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey.shade600,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             'Add some delicious items to your cart',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey.shade500,
//             ),
//           ),
//           const SizedBox(height: 30),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryBasedScreen()));
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green,
//               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               'Start Shopping',
//               style: TextStyle(fontSize: 16, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Cart Item Widget
// class CartItemWidget extends StatelessWidget {
//   final CartItem cartItem;
//   final Function(int) onQuantityChanged;
//   final VoidCallback onRemove;

//   const CartItemWidget({
//     super.key,
//     required this.cartItem,
//     required this.onQuantityChanged,
//     required this.onRemove,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       child: Row(
//         children: [
//           // Dish Image
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.network(
//               cartItem.image ?? '',
//               width: 60,
//               height: 60,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => Icon(
//                 Icons.image,
//                 size: 40,
//                 color: Colors.grey.shade400,
//               ),
//             ),
//           ),

//           const SizedBox(width: 12),

//           // Dish Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   cartItem.title,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Qty: ${cartItem.variation}',
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Quantity Controls
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   if (cartItem.quantity > 1) {
//                     onQuantityChanged(cartItem.quantity - 1);
//                   }
//                 },
//                 child: Container(
//                   width: 32,
//                   height: 32,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: cartItem.quantity > 1
//                         ? Colors.green
//                         : Colors.grey.shade300,
//                   ),
//                   child: Icon(
//                     Icons.remove,
//                     size: 18,
//                     color: cartItem.quantity > 1
//                         ? Colors.white
//                         : Colors.grey.shade600,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               SizedBox(
//                 width: 28,
//                 child: Text(
//                   cartItem.quantity.toString().padLeft(2, '0'),
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () => onQuantityChanged(cartItem.quantity + 1),
//                 child: Container(
//                   width: 32,
//                   height: 32,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.green,
//                   ),
//                   child: const Icon(
//                     Icons.add,
//                     size: 18,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(width: 12),

//           // Delete Button
//           GestureDetector(
//             onTap: onRemove,
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.red.shade50,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.delete,
//                 size: 20,
//                 color: Colors.red.shade400,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Row Item Widget for pricing summary
// class RowItem extends StatelessWidget {
//   final String label;
//   final String value;
//   final Color? valueColor;
//   final FontWeight? fontWeight;

//   const RowItem({
//     super.key,
//     required this.label,
//     required this.value,
//     this.valueColor,
//     this.fontWeight,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade700,
//               fontWeight: fontWeight,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 14,
//               color: valueColor ?? Colors.black,
//               fontWeight: fontWeight,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }








import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/provider/cart_provider.dart';
import 'package:veegify/provider/booking_provider.dart';
import 'package:veegify/views/category/category_based_screen.dart';
import 'package:veegify/views/home/payment_success_screen.dart';

// Main CartScreen wrapper that accepts scroll controller
class CartScreenWithController extends StatelessWidget {
  final ScrollController scrollController;

  const CartScreenWithController({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return CartScreen(scrollController: scrollController);
  }
}

class CartScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const CartScreen({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            if (cartProvider.items.isEmpty) {
              return const EmptyCartWidget();
            }

            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromARGB(255, 224, 244, 242),
                          child: Icon(Icons.shopping_cart, color: Colors.black),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'My Cart',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Cart List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartProvider.items.length,
                      itemBuilder: (context, index) => CartItemWidget(
                        cartItem: cartProvider.items[index],
                        onQuantityChanged: (newQuantity) {
                          cartProvider.updateQuantity(
                            cartProvider.items[index].id,
                            newQuantity,
                          );
                        },
                        onRemove: () {
                          cartProvider.removeItem(cartProvider.items[index].id);
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Coupon Field
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter Coupon Code',
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.arrow_forward, color: Colors.white),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Pricing Summary
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          RowItem(
                            label: 'Total Items',
                            value: '${cartProvider.totalItems.toString().padLeft(2, '0')}',
                          ),
                          RowItem(
                            label: 'Sub Total',
                            value: '₹${cartProvider.subtotal}.00',
                          ),
                          RowItem(
                            label: 'Delivery charge',
                            value: '₹${cartProvider.deliveryCharge}.00',
                          ),
                          const Divider(),
                          RowItem(
                            label: 'Total Payable',
                            value: '₹${cartProvider.totalPayable}.00',
                            valueColor: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Checkout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add booking to BookingProvider
                          final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
                          
                          bookingProvider.addBookingFromCart(
                            cartItems: cartProvider.items,
                            subtotal: cartProvider.subtotal,
                            deliveryCharge: cartProvider.deliveryCharge,
                            totalPayable: cartProvider.totalPayable,
                            totalItems: cartProvider.totalItems,
                          );
                          
                          // Clear cart after booking
                          cartProvider.clearCart();
                          
                          // Navigate to payment success screen
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => const PaymentSuccessScreen())
                          );
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Booking created successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    
                    // Add some bottom padding to ensure the button is not cut off
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Empty cart widget
class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Add some delicious items to your cart',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryBasedScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Start Shopping',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Cart Item Widget
class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Dish Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              cartItem.image ?? '',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                Icons.image,
                size: 40,
                color: Colors.grey.shade400,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Dish Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Qty: ${cartItem.variation}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (cartItem.quantity > 1) {
                    onQuantityChanged(cartItem.quantity - 1);
                  }
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cartItem.quantity > 1
                        ? Colors.green
                        : Colors.grey.shade300,
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 18,
                    color: cartItem.quantity > 1
                        ? Colors.white
                        : Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 28,
                child: Text(
                  cartItem.quantity.toString().padLeft(2, '0'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => onQuantityChanged(cartItem.quantity + 1),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          // Delete Button
          GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete,
                size: 20,
                color: Colors.red.shade400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Row Item Widget for pricing summary
class RowItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final FontWeight? fontWeight;

  const RowItem({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: fontWeight,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: valueColor ?? Colors.black,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}