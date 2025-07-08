import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/provider/auth_provider.dart';
import 'package:veegify/views/login_page.dart';
import 'package:veegify/widgets/bottom_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavbarProvider>(create: (_)=>BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_)=> AuthProvider())
      ],
      child:const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
      );
  }
}

