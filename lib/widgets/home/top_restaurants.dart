// import 'package:flutter/material.dart';

// // --- RestaurantCard Widget ---
// class TopRestaurantCard extends StatelessWidget {
//   final String imagePath;
//   final String name;
//   final double rating;
//   final String description;
//   final int price;

//   const TopRestaurantCard({
//     super.key,
//     required this.imagePath,
//     required this.name,
//     required this.rating,
//     required this.description,
//     required this.price,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(right: 12),
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 255, 255, 255),
//           borderRadius: BorderRadius.circular(5),
//           border: Border.all(color: const Color.fromARGB(255, 163, 163, 163))),
//       child: Container(
//         width: 186,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 120,
//                   decoration: BoxDecoration(
//                     borderRadius:
//                         const BorderRadius.vertical(top: Radius.circular(12)),
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           imagePath), // Use NetworkImage(image) if it's a URL
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: const Icon(
//                       Icons.favorite_border,
//                       size: 24,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       width: 20,
//                       height: 20,
//                       decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(12)),
//                       child:
//                           const Icon(Icons.star, color: Colors.white, size: 12),
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       rating.toString(),
//                       style: const TextStyle(
//                         color: Color.fromARGB(255, 0, 0, 0),
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   description,
//                   style: const TextStyle(
//                     color: Color.fromARGB(255, 0, 0, 0),
//                     fontSize: 12,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Icon(
//                       Icons.location_on_outlined,
//                       color: Colors.green,
//                       size: 22,
//                     ),
//                     Text(
//                       'Kakinada',
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:veegify/views/home/recommended_screen.dart';

// --- TopRestaurantCard Widget ---
class TopRestaurantCard extends StatelessWidget {
  final String id;
  final String imagePath;
  final String name;
  final double rating;
  final String description;
  final int price;

  const TopRestaurantCard({
    super.key,
    required this.id,
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantDetailScreen(restaurantId: id))),

      child: Container(
        margin: EdgeInsets.only(right: 12),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color.fromARGB(255, 163, 163, 163)),
        ),
        child: Container(
          width: 186,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Container
              Container(
                height: 120,
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                          bottom: Radius.circular(12)
                        ),
                        image: DecorationImage(
                          image: NetworkImage(imagePath),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 8,
                    //   right: 8,
                    //   child: Container(
                    //     width: 40,
                    //     height: 40,
                    //     padding: const EdgeInsets.all(4),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(25),
                    //     ),
                    //     child: const Icon(
                    //       Icons.favorite_border,
                    //       size: 24,
                    //       color: Color.fromARGB(255, 0, 0, 0),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
      
              // Content Container
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.green,
                          size: 22,
                        ),
                        Text(
                          'Kakinada',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}