import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String locationName;
  final VoidCallback onLocationTap;
  final VoidCallback? onNotificationTap;

  const HomeHeader({
    super.key,
    required this.locationName,
    required this.onLocationTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Color(0xFFEFFBF9),
          child: Icon(Icons.home),
        ),
        const SizedBox(width: 12),
        const Text(
          'Home',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onLocationTap,
              child: const Icon(
                Icons.location_pin,
                color: Colors.grey,
                size: 20,
              ),
            ),
            Text(
              locationName,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onNotificationTap,
          child: const Icon(
            Icons.notifications_none_outlined,
            size: 28,
          ),
        ),
      ],
    );
  }
}
