import 'package:flutter/material.dart';
import 'package:veegify/views/home/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
            const  Row(
                children:  [
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
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => const CartItemWidget(),
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
                child:const Column(
                  children:  [
                    RowItem(label: 'Total Items', value: '03'),
                    RowItem(label: 'Sub Total', value: '₹225.00'),
                    RowItem(label: 'Delivery charge', value: '₹22.00'),
                    Divider(),
                    RowItem(
                      label: 'Total Payable',
                      value: '₹247.00',
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const CheckoutScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Checkout', style: TextStyle(fontSize: 18,color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Custom widget for cart item
class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://www.realsimple.com/thmb/XjaXcl_GzSqzcR0MP6h5LMdZQxQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/RS0225BETT_sweet-and-spicy-cauliflower-meatballs_71-b94b134361b4461db544ec93156556c6.jpg',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Veg panner\nfried rice',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Qty: Half',
                      style: TextStyle(color: Color.fromARGB(255, 58, 56, 56), fontSize: 13)),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.remove_circle_outline,color: Colors.green,)),
                const Text('01', style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline,color: Colors.green,)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            )
          ],
        ),
        const Divider(height: 30),
      ],
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
          Text(label),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.black,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
