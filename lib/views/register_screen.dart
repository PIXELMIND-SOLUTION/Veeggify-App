import 'package:flutter/material.dart';
import 'package:veegify/views/home/navbar_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ]),
                  child: const CircleAvatar(
                    radius: 140,
                    backgroundImage: NetworkImage(
                        'https://cdni.iconscout.com/illustration/premium/thumb/girl-filling-registration-papers-illustration-download-in-svg-png-gif-file-formats--document-form-application-user-detail-sign-up-pack-miscellaneous-illustrations-7508881.png?f=webp'),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Create Your new Password',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: '. . . . .',
                    labelText: 'Password',
                    suffixIcon:const Icon(Icons.visibility_off)),
              ),
           const   SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: '. . . . .',
                    suffixIcon: const Icon(Icons.visibility_off)),
              ),
            const  SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>NavbarScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have account?'),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
