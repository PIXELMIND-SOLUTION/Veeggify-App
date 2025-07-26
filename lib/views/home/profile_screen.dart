import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veegify/helper/storage_helper.dart';
import 'package:veegify/model/user_model.dart';
import 'package:veegify/provider/auth_provider.dart';
import 'package:veegify/views/home/booking_screen.dart';
import 'package:veegify/views/home/invoice_screen.dart';
import 'package:veegify/views/home/refer_earn_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      // Load user ID first
      await _loadUserId();
    } catch (e) {
      debugPrint('Initialization error: $e');
    }
  }

  Future<void> _loadUserId() async {
    final userData = UserPreferences.getUser();
    if (userData != null) {
      setState(() {
        user = userData;
      });
    }
  }

  void _launchAboutUsUrl() async {
    final Uri url = Uri.parse('https://web-vegiffyy.onrender.com/');

    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // or platformDefault if needed
      )) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Launch error: $e');
    }
  }

  void _launchPrivacyUsUrl() async {
    final Uri url =
        Uri.parse('https://vegiffy-policy.onrender.com/privacy-and-policy');

    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // or platformDefault if needed
      )) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Launch error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://thumbs.dreamstime.com/b/smiling-asian-cartoon-character-young-man-male-person-wearing-green-t-shirt-d-style-design-light-background-human-people-341564471.jpg'),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user!.fullName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user!.email,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user!.phoneNumber,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  )
                ],
              ),
              Divider(),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.blue),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingScreen()));
                        },
                        child: Text(
                          'Orders',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.red),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InvoiceScreen()));
                        },
                        child: Text(
                          'Invoices',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Addresses',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReferEarnScreen()));
                        },
                        child: Text(
                          'Refer & Earn',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(),
              const Row(
                children: [
                  Text(
                    'Support & Settings',
                    style: TextStyle(color: Color.fromARGB(255, 104, 102, 102)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.orange),
                          child: Icon(
                            Icons.privacy_tip,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: _launchPrivacyUsUrl,
                        child: const Text(
                          'Privacy Policy',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(255, 140, 203, 255)),
                          child: Icon(
                            Icons.info,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: _launchAboutUsUrl,
                        child: const Text(
                          'About Us',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.blue),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Help',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(255, 189, 90, 207)),
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .logout(context);
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
