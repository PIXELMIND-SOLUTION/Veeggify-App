
// cart_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/helper/storage_helper.dart';
import 'package:veegify/model/CartModel/cart_model.dart';
import 'package:veegify/model/user_model.dart';
import 'package:veegify/provider/CartProvider/cart_provider.dart';
import 'package:veegify/provider/BookingProvider/booking_provider.dart';
import 'package:veegify/views/Booking/checkout_screen.dart';
import 'package:veegify/views/PaymentSuccess/payment_success_screen.dart';

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

class CartScreen extends StatefulWidget {
  final ScrollController? scrollController;

  const CartScreen({super.key, this.scrollController});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _couponController = TextEditingController();
  bool _isCouponLoading = false;
  User? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeCart();
    });
  }

  Future<void> _initializeCart() async {
      await _loadUserId();

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.loadCart(user?.userId.toString());
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
    _couponController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, Color backgroundColor) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _applyCoupon(CartProvider cartProvider) async {
    if (_couponController.text.trim().isEmpty) {
      _showSnackBar('Please enter a coupon code', Colors.red);
      return;
    }

    setState(() => _isCouponLoading = true);

    try {
      final success =
          await cartProvider.applyCoupon(_couponController.text.trim());

      if (mounted) {
        setState(() => _isCouponLoading = false);

        if (success) {
          _showSnackBar('Coupon applied successfully!', Colors.green);
          _couponController.clear();
        } else {
          _showSnackBar(
              cartProvider.error ?? 'Failed to apply coupon', Colors.red);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isCouponLoading = false);
        _showSnackBar('Error: $e', Colors.red);
      }
    }
  }

  Future<void> _removeCoupon(CartProvider cartProvider) async {
    try {
      final success = await cartProvider.removeCoupon();
      if (success) {
        _showSnackBar('Coupon removed', Colors.green);
      } else {
        _showSnackBar(
            cartProvider.error ?? 'Failed to remove coupon', Colors.red);
      }
    } catch (e) {
      _showSnackBar('Error: $e', Colors.red);
    }
  }

  Future<void> _handleCheckout(CartProvider cartProvider) async {
    try {
      _showSnackBar('Processing order...', Colors.blue);


      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const CheckoutScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Failed to place order: $e', Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            if (cartProvider.isLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.green),
                    SizedBox(height: 16),
                    Text('Loading cart...'),
                  ],
                ),
              );
            }

            if (cartProvider.error != null && !cartProvider.hasItems) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${cartProvider.error}',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _initializeCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Retry',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            }

            if (!cartProvider.hasItems) {
              return const EmptyCartWidget();
            }

            return RefreshIndicator(
              onRefresh: () => cartProvider.loadCart(user?.userId.toString()),
              child: SingleChildScrollView(
                controller: widget.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 20),
                      _buildCartList(cartProvider),
                      const SizedBox(height: 10),
                      _buildCouponSection(cartProvider),
                      const SizedBox(height: 20),
                      _buildPricingSummary(cartProvider),
                      const SizedBox(height: 20),
                      _buildCheckoutButton(cartProvider),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
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
    );
  }

  // Widget _buildCartList(CartProvider cartProvider) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: cartProvider.items.length,
  //     itemBuilder: (context, index) {
  //       final item = cartProvider.items[index];
  //       return CartItemWidget(
  //         cartProduct: item,
  //         onIncrement: () async {
  //           try {
  //             await cartProvider.incrementQuantity(item.id);
  //           } catch (e) {
  //             _showSnackBar('Failed to update: $e', Colors.red);
  //           }
  //         },
  //         onDecrement: () async {
  //           try {
  //             await cartProvider.decrementQuantity(item.id);
  //           } catch (e) {
  //             _showSnackBar('Failed to update: $e', Colors.red);
  //           }
  //         },
  //         onRemove: () async {
  //           try {
  //             await cartProvider.removeItem(item.id);
  //             _showSnackBar('Item removed', Colors.green);
  //           } catch (e) {
  //             _showSnackBar('Failed to remove: $e', Colors.red);
  //           }
  //         },
  //       );
  //     },
  //   );
  // }


  Widget _buildCartList(CartProvider cartProvider) {
  // ✅ Print all cart items
  for (var item in cartProvider.items) {
    print("Cart Item -> ID: ${item.id}, Name: ${item.name}, Qty: ${item.quantity},");
  }

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: cartProvider.items.length,
    itemBuilder: (context, index) {
      final item = cartProvider.items[index];
      return CartItemWidget(
        cartProduct: item,
        onIncrement: () async {
          try {
            await cartProvider.incrementQuantity(item.id);
          } catch (e) {
            _showSnackBar('Failed to update: $e', Colors.red);
          }
        },
        onDecrement: () async {
          try {
            await cartProvider.decrementQuantity(item.id);
          } catch (e) {
            _showSnackBar('Failed to update: $e', Colors.red);
          }
        },
        onRemove: () async {
          try {
            await cartProvider.removeItem(item.id);
            _showSnackBar('Item removed', Colors.green);
          } catch (e) {
            _showSnackBar('Failed to remove: $e', Colors.red);
          }
        },
      );
    },
  );
}


  Widget _buildCouponSection(CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cartProvider.appliedCoupon != null) ...[
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    cartProvider.appliedCoupon!.code,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '₹${cartProvider.couponDiscount} saved',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => _removeCoupon(cartProvider),
                  child: const Text('Remove',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ] else ...[
            // const Text(
            //   'Have a coupon code?',
            //   style: TextStyle(fontWeight: FontWeight.w600),
            // ),
            // const SizedBox(height: 8),
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextField(
            //         controller: _couponController,
            //         decoration: InputDecoration(
            //           hintText: 'Enter Coupon Code',
            //           filled: true,
            //           fillColor: Colors.white,
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(8),
            //             borderSide: BorderSide.none,
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     GestureDetector(
            //       onTap: _isCouponLoading
            //           ? null
            //           : () => _applyCoupon(cartProvider),
            //       child: Container(
            //         padding: const EdgeInsets.all(12),
            //         decoration: BoxDecoration(
            //           color: _isCouponLoading ? Colors.grey : Colors.green,
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         child: _isCouponLoading
            //             ? const SizedBox(
            //                 width: 20,
            //                 height: 20,
            //                 child: CircularProgressIndicator(
            //                   color: Colors.white,
            //                   strokeWidth: 2,
            //                 ),
            //               )
            //             : const Icon(Icons.arrow_forward, color: Colors.white),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ],
      ),
    );
  }

  Widget _buildPricingSummary(CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          RowItem(
            label: 'Total Items',
            value: cartProvider.totalItems.toString().padLeft(2, '0'),
          ),
          RowItem(
            label: 'Sub Total',
            value: '₹${cartProvider.subtotal.toStringAsFixed(2)}',
          ),
          if (cartProvider.couponDiscount > 0)
            RowItem(
              label: 'Coupon Discount',
              value: '-₹${cartProvider.couponDiscount.toStringAsFixed(2)}',
              valueColor: Colors.green,
            ),
          RowItem(
            label: 'Delivery charge',
            value: '₹${cartProvider.deliveryCharge.toStringAsFixed(2)}',
          ),
          const Divider(),
          RowItem(
            label: 'Total Payable',
            value: '₹${cartProvider.totalPayable.toStringAsFixed(2)}',
            valueColor: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(CartProvider cartProvider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (cartProvider.isLoading || !cartProvider.hasItems)
            ? null
            : () => _handleCheckout(cartProvider),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          disabledBackgroundColor: Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: cartProvider.isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Processing...',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              )
            : const Text(
                'Checkout',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
      ),
    );
  }
}

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
          // ElevatedButton(
          //   onPressed: () => Navigator.of(context).pop(),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.green,
          //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   child: const Text(
          //     'Start Shopping',
          //     style: TextStyle(fontSize: 16, color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartProduct cartProduct;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.cartProduct,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              cartProduct.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (_, __, ___) => Container(
                width: 60,
                height: 60,
                color: Colors.grey.shade200,
                child: Icon(
                  Icons.image,
                  size: 30,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartProduct.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Size: ${cartProduct.addOn.variation}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                if (cartProduct.addOn.plateitems > 0) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Plates: ${cartProduct.addOn.plateitems}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  '₹${cartProduct.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onDecrement,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.remove,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 28,
                child: Text(
                  cartProduct.quantity.toString().padLeft(2, '0'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onIncrement,
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