

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:veegify/provider/AuthProvider/auth_provider.dart';
import 'package:veegify/views/Auth/login_page.dart';

class ScreenOtp extends StatefulWidget {
  const ScreenOtp({super.key});

  @override
  State<ScreenOtp> createState() => _ScreenOtpState();
}

class _ScreenOtpState extends State<ScreenOtp> {
  final TextEditingController _otpController = TextEditingController();
  String _currentOtp = '';

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        // Ensures the scroll view resizes when the keyboard appears
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Prevent infinite height
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 10),

              // Profile image
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 149,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPHslEuUEmK912EWkZFplnGzD1FgrhXjI1cw&s',
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Enter OTP text
              const Text(
                'Enter OTP',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              // OTP input field
              SizedBox(
                width: 245,
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  controller: _otpController,
                  onChanged: (value) => _currentOtp = value,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    activeColor: const Color.fromARGB(255, 104, 102, 102),
                    selectedColor: Colors.green,
                    inactiveColor: const Color.fromARGB(255, 96, 96, 96),
                  ),
                ),
              ),

              // Resend OTP button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Implement resend OTP functionality
                  },
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Next button
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: authProvider.isLoading
                          ? null
                          : () {
                              if (_currentOtp.length == 4) {
                                authProvider.verifyOtp(
                                  otp: _currentOtp,
                                  context: context,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please enter complete OTP"),
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: authProvider.isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              "Next",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Sign in link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have account? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}