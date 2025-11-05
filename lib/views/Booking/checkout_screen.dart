// checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/helper/storage_helper.dart';
import 'package:veegify/model/user_model.dart';
import 'package:veegify/provider/CartProvider/cart_provider.dart';
import 'package:veegify/model/address_model.dart';
import 'package:veegify/model/CartModel/cart_model.dart';
import 'package:veegify/provider/address_provider.dart';
import 'package:veegify/services/order_service.dart';
import 'package:veegify/views/PaymentSuccess/payment_success_screen.dart';
import 'package:veegify/views/address/address_list.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _selectedAddressId;
  String? _selectedPaymentMethod;
  bool _isProcessingOrder = false;
    User? user;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserId();
      _loadAddresses();
      _loadCart();
    });
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


  Future<void> _loadAddresses() async {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    await addressProvider.loadAddresses();
  }

  Future<void> _loadCart() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.loadCart(user?.userId.toString());
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

  bool get _canPlaceOrder {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return _selectedAddressId != null &&
        _selectedPaymentMethod != null &&
        !_isProcessingOrder &&
        cartProvider.hasItems;
  }

  Future<void> _placeOrder() async {
    if (!_canPlaceOrder) return;

    setState(() => _isProcessingOrder = true);

    try {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);

      // Get cart items for order
      final cartItems = cartProvider.items;
      
      print('=== ORDER DETAILS ===');
      print('Total Items: ${cartProvider.totalItems}');
      print('Subtotal: ${cartProvider.subtotal}');
      print('Delivery Charge: ${cartProvider.deliveryCharge}');
      print('Coupon Discount: ${cartProvider.couponDiscount}');
      print('Total Payable: ${cartProvider.totalPayable}');
      print('Selected Address ID: $_selectedAddressId');
      print('Payment Method: $_selectedPaymentMethod');
      print('Cart Items:');
      for (var item in cartItems) {
        print('  - ${item.name} (Qty: ${item.quantity}, Price: ${item.totalPrice})');
      }

      // Create order payload
      final orderData = {
        "userId": "${user?.userId.toString()}", // Replace with actual user ID from auth
        "paymentMethod": _selectedPaymentMethod,
        "addressId": _selectedAddressId,
        // You can add additional fields if your API needs them
        "items": cartItems.map((item) => {
          "productId": item.id,
          "name": item.name,
          "quantity": item.quantity,
          "price": item.basePrice,
          "totalPrice": item.totalPrice,
          "variation": item.addOn.variation,
          "plateItems": item.addOn.plateitems,
        }).toList(),
        "subtotal": cartProvider.subtotal,
        "deliveryCharge": cartProvider.deliveryCharge,
        "couponDiscount": cartProvider.couponDiscount,
        "totalAmount": cartProvider.totalPayable,
      };

      // Call order service
      final result = await OrderService.createOrder(orderData);

      if (result['success']) {
        // Clear cart after successful order
        await cartProvider.clearCart();

        if (mounted) {
          _showSnackBar('Order placed successfully!', Colors.green);

          // Navigate to payment success screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>    PaymentSuccessScreen(userId:user?.userId.toString()),
            ),
          );
        }
      } else {
        if (mounted) {
          _showSnackBar(
            result['message'] ?? 'Failed to place order',
            Colors.red,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error placing order: $e', Colors.red);
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessingOrder = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Checkout'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer2<CartProvider, AddressProvider>(
        builder: (context, cartProvider, addressProvider, child) {
          // Show loading if cart or address is loading
          if (cartProvider.isLoading || addressProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }

          // Show error if cart is empty
          if (!cartProvider.hasItems) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Add items to proceed with checkout'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Go Back',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Cart Items Section
                _buildCartItemsSection(cartProvider),

                const SizedBox(height: 16),

                // Delivery Address Section
                _buildAddressSection(addressProvider),

                const SizedBox(height: 16),

                // Payment Method Section
                _buildPaymentMethodSection(),

                const SizedBox(height: 16),

                // Price Summary
                _buildPriceSummary(cartProvider),

                const SizedBox(height: 20),

                // Place Order Button
                _buildPlaceOrderButton(),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCartItemsSection(CartProvider cartProvider) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order Items',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${cartProvider.totalItems} items',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartProvider.items.length,
            separatorBuilder: (_, __) => const Divider(height: 20),
            itemBuilder: (context, index) {
              final item = cartProvider.items[index];
              return _buildCartItemTile(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemTile(CartProduct item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 60,
              height: 60,
              color: Colors.grey.shade200,
              child: Icon(Icons.image, color: Colors.grey.shade400),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Size: ${item.addOn.variation}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              if (item.addOn.plateitems > 0) ...[
                Text(
                  'Plates: ${item.addOn.plateitems}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Qty: ${item.quantity}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '₹${item.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSection(AddressProvider addressProvider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  // Navigate to add address screen
                  Navigator.push(context, MaterialPageRoute(builder: (_) => AddressList()));
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add New'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (addressProvider.addresses.isEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'No addresses found. Please add a delivery address.',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: addressProvider.addresses.length,
              itemBuilder: (context, index) {
                final address = addressProvider.addresses[index];
                final isSelected = _selectedAddressId == address.id;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAddressId = address.id;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.green.shade50
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: isSelected ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      address.addressType,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                address.fullAddress ?? address.formattedAddress,
                                style: const TextStyle(fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
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
  }

  Widget _buildPaymentMethodSection() {
    final paymentMethods = [
      {
        'title': 'Cash on Delivery',
        'value': 'COD',
        'icon': Icons.money,
        'description': 'Pay when you receive',
      },
      {
        'title': 'Online Payment',
        'value': 'Online',
        'icon': Icons.payment,
        'description': 'UPI, Card, Net Banking',
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...paymentMethods.map((method) {
            final isSelected = _selectedPaymentMethod == method['value'];

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPaymentMethod = method['value'] as String;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      isSelected ? Colors.green.shade50 : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: isSelected ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        method['icon'] as IconData,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            method['title'] as String,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            method['description'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPriceSummary(CartProvider cartProvider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildPriceRow(
            'Sub Total',
            '₹${cartProvider.subtotal.toStringAsFixed(2)}',
          ),
          if (cartProvider.couponDiscount > 0)
            _buildPriceRow(
              'Coupon Discount',
              '-₹${cartProvider.couponDiscount.toStringAsFixed(2)}',
              valueColor: Colors.green,
            ),
          _buildPriceRow(
            'Delivery Charge',
            '₹${cartProvider.deliveryCharge.toStringAsFixed(2)}',
          ),
          const Divider(height: 20),
          _buildPriceRow(
            'Total Payable',
            '₹${cartProvider.totalPayable.toStringAsFixed(2)}',
            valueColor: Colors.green,
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
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
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: valueColor ?? Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _canPlaceOrder ? _placeOrder : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            disabledBackgroundColor: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isProcessingOrder
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
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : Text(
                  _canPlaceOrder ? 'Place Order' : 'Select Address & Payment',
                  style: TextStyle(
                    fontSize: 18,
                    color: _canPlaceOrder ? Colors.white : Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}