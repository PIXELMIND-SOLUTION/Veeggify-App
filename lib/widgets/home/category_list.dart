import 'package:flutter/material.dart';
import 'package:veegify/views/Category/category_based_screen.dart';

class CategoryCard extends StatelessWidget {
  final String id;
  final String imagePath;
  final String title;
  final String userId;

  const CategoryCard({
    super.key,
    required this.id,
    required this.imagePath,
    required this.title,
    required this.userId
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryBasedScreen(categoryId:id, title: title, userId:userId)));
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFEBF4F1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(imagePath),
            ),
            const SizedBox(height: 8),
            Flexible( // Ensure text wraps without overflow
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
