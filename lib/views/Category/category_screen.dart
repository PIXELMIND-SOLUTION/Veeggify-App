import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/provider/CategoryProvider/category_provider.dart';
import 'package:veegify/views/Category/category_based_screen.dart';
import 'package:veegify/views/Category/top_restaurants_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String userId;
  const CategoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  child: SizedBox(
    height: 48,
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Centered Title
        const Center(
          child: Text(
            "Categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // iOS-style Back Icon on the left
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    ),
  ),
),


            // Body
            Expanded(
              child: Consumer<CategoryProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (provider.error != null) {
                    return Center(child: Text('Error: ${provider.error}'));
                  }

                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: GridView.builder(
                      itemCount: provider.categories.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, index) {
                        final category = provider.categories[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryBasedScreen(categoryId: category.id, title: category.categoryName, userId: userId,))),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBF4F1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(category.imageUrl),
                                  backgroundColor: Colors.transparent,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category.categoryName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
