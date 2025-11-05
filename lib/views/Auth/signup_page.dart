import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/provider/AuthProvider/auth_provider.dart';
import 'package:veegify/views/Auth/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController referalController = TextEditingController();

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final firstName = firstNameController.text.trim();
      final lastName = lastNameController.text.trim();
      final phone = phoneController.text.trim();
      final email = emailController.text.trim();
      final referalCode = referalController.text.trim();

      context.read<AuthProvider>().register(
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            email: email,
            referalCode: referalCode,
            context: context,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset("assets/images/signup.png", width: 300, height: 300),
                const SizedBox(height: 30),
                const Text(
                  'Create your new account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 30),

                // First and Last Name
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: _inputDecoration('First Name*'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'First name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: _inputDecoration('Last Name*'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Last name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Phone
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: _inputDecoration('Phone*'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Phone number is required';
                    } else if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
                      return 'Enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration('Email*'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                        .hasMatch(value.trim())) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Referral (optional or required, adjust accordingly)
                TextFormField(
                  controller: referalController,
                  decoration: _inputDecoration('Referral Code (optional)'),
                ),

                const SizedBox(height: 25),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
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

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    referalController.dispose();
    super.dispose();
  }
}
