import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veegify/helper/storage_helper.dart';
import 'package:veegify/model/user_model.dart';
import 'package:veegify/provider/AuthProvider/auth_provider.dart';
import 'package:veegify/views/ProfileScreen/help_screen.dart';
import 'package:veegify/views/Booking/booking_screen.dart';
import 'package:veegify/views/address/address_list.dart';
import 'package:veegify/views/home/invoice_screen.dart';
import 'package:veegify/views/Navbar/navbar_screen.dart';
import 'package:veegify/views/ProfileScreen/refer_earn_screen.dart';
import 'package:veegify/widgets/bottom_navbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class HystoryScreenWithController extends StatelessWidget {
  final ScrollController scrollController;

  const HystoryScreenWithController({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return HystoryScreen(scrollController: scrollController);
  }
}

class HystoryScreen extends StatefulWidget {
  final ScrollController? scrollController;

  const HystoryScreen({super.key, this.scrollController});

  @override
  State<HystoryScreen> createState() => _HystoryScreenState();
}

class _HystoryScreenState extends State<HystoryScreen> {
  User? user;
  String? imageUrl;
  bool _loading = true;
  String? _error;
  List<dynamic> _orders = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await _loadUserId();
      await _fetchUserProfile();
      await _fetchPreviousOrders();
    } catch (e) {
      debugPrint('Initialization error: $e');
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
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

  Future<void> _fetchUserProfile() async {
    if (user == null) return;
    try {
      final url = Uri.parse("http://31.97.206.144:5051/api/usersprofile/${user!.userId}");
      print("iiiiiiiiiiiiii$url");
      final response = await http.get(url);
print("Response : ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userData = data['user'];

        setState(() {
          imageUrl = userData['profileImg'] ?? '';
          user = User(
            userId: userData['_id'],
            fullName: userData['fullName'] ?? '',
            email: userData['email'] ?? '',
            phoneNumber: userData['phoneNumber'] ?? '',
            profileImg: userData['profileImg'] ?? '',
          );
        });

        debugPrint("✅ Profile fetched successfully");
      } else {
        debugPrint("❌ Failed to fetch profile: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    }
  }

  Future<void> _fetchPreviousOrders() async {
    if (user == null) {
      debugPrint("User is null; skipping previous orders fetch.");
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final url = Uri.parse("http://31.97.206.144:5051/api/userpreviousorders/${user!.userId}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        if (body['success'] == true && body['data'] is List) {
          setState(() {
            _orders = body['data'];
          });
        } else {
          setState(() {
            _error = "No orders found";
          });
        }
      } else {
        setState(() {
          _error = "Failed to fetch orders (${response.statusCode})";
        });
      }
    } catch (e) {
      setState(() {
        _error = "Error fetching orders: $e";
      });
      debugPrint("Error fetching previous orders: $e");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _handleProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final file = File(pickedFile.path);
    final url = Uri.parse("http://31.97.206.144:5051/api/uploadprofile-image/${user?.userId}");
    final request = http.MultipartRequest("PUT", url);
    request.files.add(await http.MultipartFile.fromPath("image", file.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      debugPrint("✅ Image uploaded successfully");

      // Refresh from server
      await _fetchUserProfile();

      setState(() {});
    } else {
      final resBody = await response.stream.bytesToString();
      debugPrint("❌ Upload failed (${response.statusCode}): $resBody");
    }
  }

  void _handleBackButton() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const NavbarScreen(),
      ),
      (route) => false,
    );

    Provider.of<BottomNavbarProvider>(context, listen: false).setIndex(0);
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    // pick first product for main display (as in screenshot)
    final products = order['products'] as List<dynamic>? ?? [];
    final mainProduct = products.isNotEmpty ? products[0] : null;
    final imageUrl = mainProduct != null ? (mainProduct['image'] ?? '') : '';
    final name = mainProduct != null ? (mainProduct['name'] ?? 'Item') : 'Item';
    final price = mainProduct != null ? (mainProduct['basePrice'] ?? 0) : 0;
    final subTitle = order['restaurantId'] != null ? (order['restaurantId']['restaurantName'] ?? '') : '';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Left side text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  '₹$price',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.green),
                    const SizedBox(width: 6),
                    Text('4.2', style: TextStyle(color: Colors.green[700])),
                    const SizedBox(width: 8),
                    Text('(${(order['totalItems'] ?? 1)})', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  order['orderStatus'] == 'Completed' ? 'Delivered' : (order['deliveryStatus'] ?? ''),
                  style: TextStyle(
                    color: order['orderStatus'] == 'Completed' ? Colors.red : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Right side image with overlays
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: imageUrl != null && imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : const AssetImage('assets/placeholder.png') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Heart (favorite) icon - top right
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.red, size: 20),
                    onPressed: () {
                      // handle favorite toggle
                    },
                  ),
                ),
              ),

              // Reorder button - bottom center
              Positioned(
                bottom: -10,
                left: 10,
                right: 10,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // reorder action: navigate to booking or cart
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => BookingScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    ),
                    child: const Text(
                      'Reorder',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text(_error!, style: const TextStyle(color: Colors.red)));
    }

    if (_orders.isEmpty) {
      return const Center(child: Text('No previous orders'));
    }

    return ListView.builder(
      controller: widget.scrollController,
      padding: const EdgeInsets.only(top: 16, bottom: 80),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index] as Map<String, dynamic>;
        return _buildOrderCard(order);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previous Orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _handleBackButton,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(child: _buildBody()),
    );
  }
}
