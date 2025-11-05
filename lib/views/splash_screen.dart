import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/helper/storage_helper.dart';
import 'package:veegify/provider/AuthProvider/auth_provider.dart';
import 'package:veegify/provider/LocationProvider/location_provider.dart';
import 'package:veegify/views/Auth/login_page.dart';
import 'package:veegify/views/Navbar/navbar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String? userId;
  late AnimationController _controller;
  late Animation<Offset> _slideUpAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _checkLoginStatus();
  }

  void _initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _slideUpAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  Future<void> _loadUserId() async {
    final user = UserPreferences.getUser();
    if (user != null && mounted) {
      setState(() {
        userId = user.userId;
      });
    }
  }

  Future<void> _handleCurrentLocation() async {
    try {
      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);
      await locationProvider.initLocation(userId.toString());
    } catch (e) {
      debugPrint('Location error: $e');
    }
  }

  Future<void> _checkLoginStatus() async {
    await UserPreferences.init();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkLoginStatus();

    _controller.forward();

    if (UserPreferences.isLoggedIn()) {
      await _loadUserId();
      await _handleCurrentLocation();
    }

    await Future.delayed(const Duration(seconds: 2));

    if (UserPreferences.isLoggedIn()) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => NavbarScreen()),
        );
      }
    } else {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Center(
          child: SlideTransition(
            position: _slideUpAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Improved Location Pin Logo with better scaling
                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // Logo inside - centered and properly sized
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          'assets/images/logolocation.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),
                  
                  // App Name - Bold
              ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds),
                    child: Text(
                      'Vegiffyy',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2.0,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0, 4),
                            blurRadius: 8,
                          ),
                          Shadow(
                            color: Colors.white.withOpacity(0.5),
                            offset: const Offset(0, -1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Tagline - Bold
                  const Text(
                    'Fresh groceries delivered to your door',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Location Display
                  AnimatedOpacity(
                    opacity: locationProvider.hasLocation ? 1.0 : 0.65,
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 32),
  
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              locationProvider.hasLocation
                                  ? locationProvider.address
                                  : 'Locating you...',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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