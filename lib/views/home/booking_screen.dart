// import 'package:flutter/material.dart';

// class BookingScreen extends StatefulWidget {
//   const BookingScreen({super.key});

//   @override
//   State<BookingScreen> createState() => _BookingScreenState();
// }

// class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const Icon(Icons.arrow_back_ios),
//         title: const Text("Bookings", style: TextStyle(fontWeight: FontWeight.bold)),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(60),
//           child: TabBar(
//             controller: _tabController,
//             isScrollable: true,
//             indicatorColor: Colors.green,
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.black,
//             indicator: BoxDecoration(
//               color: Colors.green,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             tabs: const [
//               Padding(
//                 padding: EdgeInsets.all(2.0),
//                 child: Tab(text: "Today Bookings"),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(2.0),
//                 child: Tab(text: "Total Bookings"),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(2.0),
//                 child: Tab(text: "Cancelled Bookings"),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildBookingList("Today"),     // Tab 1
//           _buildBookingList2("Total"),     // Tab 2
//           _buildBookingList3("Cancelled"),
//          // Tab 3
//         ],
//       ),
//     );
//   }

//   Widget _buildBookingList(String type) {
//     // Dummy content to demo multiple cards per tab
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 1,
//       itemBuilder: (context, index) => Padding(
//         padding: const EdgeInsets.only(bottom: 16.0),
//         child: _buildBookingCard(type),
//       ),
//     );
//   }
//   Widget _buildBookingList2(String type) {
//     // Dummy content to demo multiple cards per tab
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 1,
//       itemBuilder: (context, index) => Padding(
//         padding: const EdgeInsets.only(bottom: 16.0),
//         child: _buildBookingCard2(type),
//       ),
//     );
//   }

//     Widget _buildBookingList3(String type) {
//     // Dummy content to demo multiple cards per tab
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 1,
//       itemBuilder: (context, index) => Padding(
//         padding: const EdgeInsets.only(bottom: 16.0),
//         child: _buildBookingCard3(type),
//       ),
//     );
//   }


//   Widget _buildBookingCard(String type) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             // Food Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: const [
//                       Icon(Icons.radio_button_checked, color: Colors.green, size: 16),
//                       SizedBox(width: 6),
//                       Text(
//                         "Veg Paneer Fried Rice",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "₹250",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 6),
//                   const Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.green, size: 16),
//                       SizedBox(width: 4),
//                       Text("4.2 (2941)", style: TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "Deliciously decadent flavored dum rice l...",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.network(
//                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq4gWI99HaYEe1XSrMDUYZ_7rQzodW3R0GeA&s',
//                     width: 100,
//                     height: 80,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Text(
//                     "5mins",
//                     style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//    Widget _buildBookingCard2(String type) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             // Food Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: const [
//                       Icon(Icons.radio_button_checked, color: Colors.green, size: 16),
//                       SizedBox(width: 6),
//                       Text(
//                         "Veg Paneer Fried Rice",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "₹250",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 6),
//                   const Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.green, size: 16),
//                       SizedBox(width: 4),
//                       Text("4.2 (2941)", style: TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "Deliciously decadent flavored dum rice l...",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.network(
//                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq4gWI99HaYEe1XSrMDUYZ_7rQzodW3R0GeA&s',
//                     width: 100,
//                     height: 80,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Text(
//                     "completed",
//                     style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildBookingCard3(String type) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             // Food Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: const [
//                       Icon(Icons.radio_button_checked, color: Colors.green, size: 16),
//                       SizedBox(width: 6),
//                       Text(
//                         "Veg Paneer Fried Rice",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "₹250",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 6),
//                   const Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.green, size: 16),
//                       SizedBox(width: 4),
//                       Text("4.2 (2941)", style: TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "Deliciously decadent flavored dum rice l...",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.network(
//                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq4gWI99HaYEe1XSrMDUYZ_7rQzodW3R0GeA&s',
//                     width: 100,
//                     height: 80,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Text(
//                     "Cancelled",
//                     style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }









import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: () {  
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
        title: const Text(
          "Bookings", 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          )
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black54,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              indicator: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              tabAlignment: TabAlignment.start,
              tabs: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.access_time, size: 16),
                      SizedBox(width: 6),
                      Text("Today Bookings"),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.receipt_long, size: 16),
                      SizedBox(width: 6),
                      Text("Total Bookings"),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.cancel_outlined, size: 16),
                      SizedBox(width: 6),
                      Text("Cancelled Bookings"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList("Today"),
          _buildBookingList("Total"),
          _buildBookingList("Cancelled"),
        ],
      ),
    );
  }

  Widget _buildBookingList(String type) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 1,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _buildBookingCard(type),
      ),
    );
  }

  Widget _buildBookingCard(String type) {
    String statusText;
    Color statusColor;
    
    switch (type) {
      case "Today":
        statusText = "5mins";
        statusColor = Colors.green;
        break;
      case "Total":
        statusText = "Completed";
        statusColor = Colors.green;
        break;
      case "Cancelled":
        statusText = "Cancelled";
        statusColor = Colors.red;
        break;
      default:
        statusText = "5mins";
        statusColor = Colors.green;
    }

    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: 12,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Veg paneer fried rice",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "₹250",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.green, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "4.2 (2941)",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          "Deliciously decadent flavored dum rice l...",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        "more",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq4gWI99HaYEe1XSrMDUYZ_7rQzodW3R0GeA&s',
                        width: 100,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (type == "Cancelled")
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "Cancelled",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                if (type != "Cancelled")
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: statusColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}