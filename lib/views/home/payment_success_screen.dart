import 'package:flutter/material.dart';
import 'package:veegify/views/home/chat_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: Icon(Icons.arrow_back_ios))
                  ],
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage('https://www.kablooe.com/wp-content/uploads/2019/08/check_mark.png'),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Payment Successfull',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),)
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Your booking Confirmed',style: TextStyle(color: Colors.grey),)
                  ],
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You have successfully Booked Your Service\nWe sent you details of your booking to your\nmobile number you can check on my bookings',style: TextStyle(color: Colors.grey),)
                  ],
                ),
                SizedBox(height: 250,),
                 SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChatScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ),
              ),
              ],
            ),
            )
          ),
    );
  }
}