import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:veegify/provider/auth_provider.dart';
import 'package:veegify/views/ForgotPassword/reset_password_screen.dart';
import 'package:veegify/views/Auth/login_page.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String _currentOtp = '';
  bool _isOtpSent = false;
  String? _userId;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Phone number must contain only digits';
    }
    return null;
  }

  void _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      try {
        await authProvider.sendForgotPasswordOtp(
          phoneNumber: _phoneController.text,
          context: context,
        );
        
        setState(() {
          _isOtpSent = true;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("OTP sent successfully"),
            backgroundColor: Colors.green,
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to send OTP: ${error.toString()}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _verifyOtp() async {
    if (_currentOtp.length == 4) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      try {
        final response = await authProvider.verifyForgotPasswordOtp(
          otp: _currentOtp,
          context: context,
        );
        
        if (response != null && response['userId'] != null) {
          _userId = response['userId'];
          
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(userId: _userId!),
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("OTP verification failed: ${error.toString()}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter complete OTP"),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _resendOtp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    try {
      await authProvider.sendForgotPasswordOtp(
        phoneNumber: _phoneController.text,
        context: context,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP resent successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to resend OTP: ${error.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                        radius: 80,
                        backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPHslEuUEmK912EWkZFplnGzD1FgrhXjI1cw&s',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Title
                  Text(
                    _isOtpSent ? 'Enter OTP' : 'Forgot Password',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Subtitle
                  Text(
                    _isOtpSent 
                        ? 'Enter the 4-digit code sent to ${_phoneController.text}'
                        : 'Enter your phone number to receive OTP',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  // Phone number input (only show if OTP not sent)
                  if (!_isOtpSent) ...[
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: _validatePhoneNumber,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                        prefixText: '+91 ',
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],

                  // OTP input field (only show if OTP sent)
                  if (_isOtpSent) ...[
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
                        onPressed: _resendOtp,
                        child: const Text(
                          "Resend OTP",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],

                  // Action button
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: authProvider.isLoading
                              ? null
                              : _isOtpSent ? _verifyOtp : _sendOtp,
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
                              : Text(
                                  _isOtpSent ? "Verify OTP" : "Send OTP",
                                  style: const TextStyle(fontSize: 16, color: Colors.white),
                                ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Back to sign in link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Remember your password? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
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
      ),
    );
  }
}