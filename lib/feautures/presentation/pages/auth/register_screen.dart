import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: Icon(Icons.arrow_back_ios)),
            ),
            SizedBox(height: 10,),
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
                    )
                  ]
                ),
                child: CircleAvatar(
                  radius: 140,
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVi3PpbISu2jnw7SVmlyPUkaPc6ob5sbeJkw&s'
                  ),
                  
                ),
                
              ),
            ),
            SizedBox(height: 30,),
            Text('Create Your new Password',
            style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,fontSize: 22 ),
            ),

            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  
                ),
                hintText: '. . . . .',
                suffixIcon: Icon(Icons.visibility_off)

              ),
            ),
            SizedBox(height: 30,),
             TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  
                ),
                hintText: '. . . . .',
                suffixIcon: Icon(Icons.visibility_off)

              ),
            ),
            SizedBox(height: 40,),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterScreen()));
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
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have account?'),
                  TextButton(onPressed: (){}, child: Text('Sign in',
                  style: TextStyle(color: Colors.blue),
                  ))
                ],
              )
          ],
        ),
        )
      ),
    );
  }
}