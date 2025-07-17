import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  final String titleLine1;
  final String titleLine2;
  final String buttonText;
  final VoidCallback onPressed;
  final String imageAssetPath;
  final Color backgroundColor;
  final double borderRadius;

  const PromoBanner({
    super.key,
    required this.titleLine1,
    required this.titleLine2,
    required this.buttonText,
    required this.onPressed,
    required this.imageAssetPath,
    this.backgroundColor = const Color(0xFFEFFBF9),
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleLine1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  titleLine2,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            imageAssetPath,
            width: 106,
            height: 106,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
