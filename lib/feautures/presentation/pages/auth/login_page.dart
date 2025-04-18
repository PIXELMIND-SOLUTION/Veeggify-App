import 'package:flutter/material.dart';
import 'package:veegify/feautures/presentation/pages/auth/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 140,
                  backgroundImage: NetworkImage(
                    'https://media.istockphoto.com/id/1314333578/photo/delivery-man-riding-a-motorcycle-with-delivery-box-3d-rendering.jpg?s=612x612&w=0&k=20&c=vwAa0MruvqhN7kEtkRLJu6rvYdaqx-ivT_g7-tG50oY=',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Welcome back glad to see you',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: 'User Name Or Email Address',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
               TextField(
                decoration: InputDecoration(
                  hintText: 'Type your user name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(
                    text: 'Password',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
               TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '......',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  suffixIcon:const Icon(Icons.visibility_off),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (value) {}),
                  const Text('Remember me'),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Log In'),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Your Password?'),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignupPage()));
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
