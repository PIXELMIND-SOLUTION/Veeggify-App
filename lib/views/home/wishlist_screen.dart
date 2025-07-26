// import 'package:flutter/material.dart';

// class FavouriteScreen extends StatelessWidget {
//   const FavouriteScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       // Navigator.of(context).pop();
//                     }, icon: const Icon(Icons.arrow_back_ios)),
//                 const SizedBox(
//                   width: 30,
//                 ),
//                 const Text(
//                   'Favourites',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
//                 )
//               ],
//             ),
//             Expanded(
//                 child: ListView.builder(
//                     itemCount: 2,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 20),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Expanded(
//                                 child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.stop_circle,
//                                       color: Colors.green,
//                                       size: 18,
//                                     ),
//                                     SizedBox(
//                                       width: 4,
//                                     ),
//                                     Text(
//                                       'Veg panner fried rice',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   '250',
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(
//                                   height: 4,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.star,
//                                       color: Colors.green,
//                                       size: 16,
//                                     ),
//                                     SizedBox(
//                                       width: 4,
//                                     ),
//                                     Text(
//                                       '4.2(2941)',
//                                       style: TextStyle(fontSize: 12),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 4,
//                                 ),
//                                 Text(
//                                   'Deliciously decadent flavored dum rice l... more',
//                                   style: TextStyle(fontSize: 13),
//                                 )
//                               ],
//                             )),
//                             Column(
//                               children: [
//                                 Stack(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(8),
//                                       child: Image.network(
//                                         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQULDPkJ8PfjDLulqB88WVtf4NmF2X_EurAIg&s',
//                                         height: 90,
//                                         width: 90,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     const Positioned(
//                                         right: 0,
//                                         top: 0,
//                                         child: CircleAvatar(
//                                           radius: 12,
//                                           backgroundColor: Colors.white,
//                                           child: Icon(
//                                             Icons.favorite_border,
//                                             size: 16,
//                                             color: Colors.red,
//                                           ),
//                                         ))
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 8,
//                                 ),
//                                 ElevatedButton(
//                                     onPressed: () {},
//                                     style: ElevatedButton.styleFrom(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 24, vertical: 4),
//                                       backgroundColor: Colors.green,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'ADD',
//                                       style: TextStyle(color: Colors.white),
//                                     ))
//                               ],
//                             )
//                           ],
//                         ),
//                       );
//                     }))
//           ],
//         ),
//       )),
//     );
//   }
// }








import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Coming Soon"),
      ),
    );
  }
}