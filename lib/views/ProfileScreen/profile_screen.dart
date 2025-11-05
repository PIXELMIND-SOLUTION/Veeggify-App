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

// Main ProfileScreen wrapper that accepts scroll controller
class ProfileScreenWithController extends StatelessWidget {
  final ScrollController scrollController;

  const ProfileScreenWithController({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(scrollController: scrollController);
  }
}

class ProfileScreen extends StatefulWidget {
  final ScrollController? scrollController;

  const ProfileScreen({super.key, this.scrollController});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      // Load user ID first
      await _loadUserId();
      await _fetchUserProfile(); // Fetch fresh profile when screen opens
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

  void _handleBackButton() {
    // Navigate to NavbarScreen with home tab (index 0) and clear the stack
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const NavbarScreen(),
      ),
      (route) => false,
    );

    // Set the bottom navigation to home tab
    Provider.of<BottomNavbarProvider>(context, listen: false).setIndex(0);
  }

  Future<void> _fetchUserProfile() async {
    if (user == null) return;
    try {
      // final url = Uri.parse(
      //     "http://31.97.206.144:5051/api/users/${user!.userId}/profile");
      // final response = await http.get(url);
            final url = Uri.parse(
          "http://31.97.206.144:5051/api/usersprofile/${user!.userId}");
      final response = await http.get(url);

      print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${response.body}");

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

    // 👇 Force UI rebuild just in case
    setState(() {});
  } else {
    final resBody = await response.stream.bytesToString();
    debugPrint("❌ Upload failed (${response.statusCode}): $resBody");
  }
}


  void _launchAboutUsUrl() async {
    final Uri url = Uri.parse('https://web-vegiffyy.onrender.com/');

    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
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
        mode: LaunchMode.externalApplication,
      )) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Launch error: $e');
    }
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required Color backgroundColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: backgroundColor,
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IconButton(
                    //   onPressed: _handleBackButton,
                    //   icon: const Icon(Icons.arrow_back_ios),
                    // ),
                    Align(
                      alignment: Alignment.center,
                      child: const Text(
                        'My Account',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Profile Avatar
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    final profileUrl = "";

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _handleProfileImage();
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                (imageUrl != null && imageUrl!.isNotEmpty)
                                    ? NetworkImage(imageUrl!)
                                    : const AssetImage(
                                            'assets/images/default_avatar.png')
                                        as ImageProvider,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 15),

                // User Name
                if (user != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user!.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // User Email
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user!.email,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // User Phone
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user!.phoneNumber,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],

                const Divider(),
                const SizedBox(height: 20),

                // Profile Options
                _buildProfileOption(
                  icon: Icons.shopping_bag,
                  title: 'Orders',
                  backgroundColor: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingScreen(userId: user?.userId.toString(),)),
                    );
                  },
                ),

                _buildProfileOption(
                  icon: Icons.receipt,
                  title: 'Invoices',
                  backgroundColor: Colors.red,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InvoiceScreen()),
                    );
                  },
                ),

                _buildProfileOption(
                  icon: Icons.location_on,
                  title: 'Addresses',
                  backgroundColor: Colors.green,
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => AddressListScreen(userId: user!.userId,)),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddressList()),
                    );
                  },
                ),

                _buildProfileOption(
                  icon: Icons.card_giftcard,
                  title: 'Refer & Earn',
                  backgroundColor: Colors.black,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReferEarnScreen()),
                    );
                  },
                ),

                const SizedBox(height: 15),
                const Divider(),

                // Support & Settings Section
                const Row(
                  children: [
                    Text(
                      'Support & Settings',
                      style: TextStyle(
                          color: Color.fromARGB(255, 104, 102, 102),
                          fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                _buildProfileOption(
                  icon: Icons.privacy_tip,
                  title: 'Privacy Policy',
                  backgroundColor: Colors.orange,
                  onTap: _launchPrivacyUsUrl,
                ),

                _buildProfileOption(
                  icon: Icons.info,
                  title: 'About Us',
                  backgroundColor: const Color.fromARGB(255, 140, 203, 255),
                  onTap: _launchAboutUsUrl,
                ),

                _buildProfileOption(
                  icon: Icons.help,
                  title: 'Help',
                  backgroundColor: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpScreen()),
                    );
                  },
                ),

                _buildProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  backgroundColor: const Color.fromARGB(255, 189, 90, 207),
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .logout(context);
                  },
                ),

                // Add some bottom padding to ensure content is not cut off
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
