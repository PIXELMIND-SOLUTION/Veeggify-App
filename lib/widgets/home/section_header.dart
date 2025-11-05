import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        TextButton(
          onPressed: onSeeAll,
          child: const Row(
            children: [
              Text(
                'See All',
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Colors.black87,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
