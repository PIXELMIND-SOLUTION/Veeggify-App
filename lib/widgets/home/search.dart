import 'package:flutter/material.dart';

class SearchBarWithFilter extends StatelessWidget {
  const SearchBarWithFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFEBF4F1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              hintText: 'Search your food',
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 46,
          width: 46,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.tune,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
