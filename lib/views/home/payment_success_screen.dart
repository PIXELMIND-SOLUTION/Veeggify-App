import 'dart:async';
import 'package:flutter/material.dart';
import 'package:veegify/views/home/location_detail_screen.dart'; 

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Start animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LocationDetailScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 80),

              // Animated Checkmark
              Center(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.white,
                      backgroundImage: const NetworkImage(
                        'https://www.kablooe.com/wp-content/uploads/2019/08/check_mark.png',
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Payment Successful
              const Center(
                child: Text(
                  'Payment Successful',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              const Center(
                child: Text(
                  'Your booking is confirmed',
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              const SizedBox(height: 25),

              const Center(
                child: Text(
                  'You have successfully booked your service.\n'
                  'We sent details of your booking to your\n'
                  'mobile number. You can check it under\n'
                  '"My Bookings".',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
