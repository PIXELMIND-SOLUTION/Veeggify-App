import 'package:flutter/material.dart';
import 'package:veegify/feautures/presentation/pages/auth/otp_screen.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

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
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 140,
                  backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTcY0hCdAgzbtF2AM8B9ESuvzALzmiDNR9Ow&s',
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Create your new account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              const SizedBox(height: 30),

           
              Row(
                children: [
                 
                  Expanded(
                    child: TextFormField(
                      decoration:  InputDecoration(
                        labelText: 'First Name*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                 
                  Expanded(
                    child: TextFormField(
                      decoration:  InputDecoration(
                        labelText: 'Last Name*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

       
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration:  InputDecoration(
                  labelText: 'Phone*',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),

              const SizedBox(height: 15),

           
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration:  InputDecoration(
                  labelText: 'Email*',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),

              const SizedBox(height: 25),

            
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ScreenOtp()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have account? "),
                  GestureDetector(
                    onTap: () {
                    
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

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
