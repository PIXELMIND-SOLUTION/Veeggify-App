import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/provider/LocationProvider/location_provider.dart';
import 'package:veegify/views/Notification/notification.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Location section (left side)
          Expanded(
            child: _buildLocationWidget(context),
          ),
          
          // Notification icon (right side)
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_outlined,
                size: 22,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationWidget(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, provider, _) {
        return GestureDetector(
          onTap: onLocationTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
Icon(
  Icons.telegram_sharp,
  size: 24,       // adjust size as needed
  color: Colors.green,  // optional color
),

              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Loading or location text
                    if (provider.isLoading)
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: const Color(0xFF120698),
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  _getDisplayAddress(provider.address),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          Text(
                            provider.address.isNotEmpty ? provider.address : "Set location",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getDisplayAddress(String address) {
    print("pppppppppppppppppppppppppppppppppp$address");
    if (address.trim().isEmpty) {
      return "Set location";
    }

    String cleanAddress = address.trim();
    List<String> parts = cleanAddress.split(',');

    for (String part in parts) {
      String trimmed = part.trim();

      // Skip if starts with number or symbol
      if (trimmed.isEmpty || !RegExp(r'^[a-zA-Z]').hasMatch(trimmed)) {
        continue;
      }

      // Skip irrelevant parts
      if (trimmed.toLowerCase().contains('plot') ||
          trimmed.toLowerCase().contains('door') ||
          trimmed.toLowerCase().contains('building') ||
          trimmed.toLowerCase().contains('floor')) {
        continue;
      }

      // Return the first valid part without length limit for main title
      return trimmed;
    }

    // Fallback: show first part that starts with letter
    for (String part in parts) {
      String trimmed = part.trim();
      if (trimmed.isNotEmpty && RegExp(r'^[a-zA-Z]').hasMatch(trimmed)) {
        return trimmed;
      }
    }

    return "Location";
  }
}