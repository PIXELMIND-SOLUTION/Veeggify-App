import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/provider/location_provider.dart';

class HomeHeader extends StatelessWidget {
  final String userId;
  final VoidCallback onLocationTap;

  const HomeHeader({
    super.key,
    required this.userId,
    required this.onLocationTap,
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
        _buildLocationWidget(context),
        const SizedBox(width: 16),
        const Icon(
          Icons.notifications_none_outlined,
          size: 28,
        ),
      ],
    );
  }

  Widget _buildLocationWidget(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, provider, _) {
      final displayAddress = 
          provider.address.split(' ')[1];
        return GestureDetector(
          onTap: onLocationTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: Color(0XFF120698),
                ),
                    if (provider.isLoading)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0XFF120698),
                        ),
                      )
                    else if (provider.hasError)
                      const Text(
                        'Tap to set location',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0XFF120698),
                        ),
                      )
                    else
                      SizedBox(
                        width: 100,
                        child: Text(
                          displayAddress,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}