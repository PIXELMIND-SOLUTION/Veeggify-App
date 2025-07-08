import 'package:flutter/material.dart';
import 'package:veegify/views/home/location_screen.dart';
import 'package:veegify/views/home/recommended_screen.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
              
                 Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFFEFFBF9),
                      child: Icon(Icons.home),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationScreen()));
                          },
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        Text(
                          'Hyderabad',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Icon(
                      Icons.notifications_none_outlined,
                      size: 28,
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Search bar
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFEFFBF9),
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
                ),
                
                const SizedBox(height: 16),
                
                // Categories header
                Row(
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
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
                ),
                
                const SizedBox(height: 10),
                
                // Categories
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      CategoryCard(
                        imagePath: 'https://s3-alpha-sig.figma.com/img/08e5/bf27/df4cc55a5714f906415217e838a0ea86?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=iciv7BdlhLOfLqKpYqJBrOrbqdmSI9ujglo-i9eHL6ZRDGskHXgRrozgTOESCvlnRtRB--igea6pHg7fLF~NRpi9n2S4ymQrA2yHNQAYndcFDfxU9oqI11RWIUMrexHUVs0zRvwYgV9dRIKKrGAIyVSDSJ~k1HpAVjoIulZLdoGg-G4F3QJvW-YuNH-SukFNP2e9FNUzlXzqvpb0~IEnyFpoXM4pGXXfgpN2nbJJ04ObQN0lZs6Ja8vdFCi~o8z0RKrEvEohTcf77EHarLBlsox~BiQsp3m5I8SQk61bZcuGAoYkdBlABq0T-7INWgkIpdPfhIKcvkpWbBscQAvJdA__',
                        title: 'South\nIndian',
                      ),
                      CategoryCard(
                        imagePath: 'https://s3-alpha-sig.figma.com/img/5473/4646/88b03f2c4d0e330b88b4c7a0ca45416c?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=MbSsEKbkxIM38atSiPoM4p9rEzqnB1TuuxY~wDJcxsLlvP8tx4SeCzrrNVS3lj~~21ZIJg8B-uf1gWgrFCOPI81Cc9PZrwgrq7cRjHHR2CyLCXNTzYim6Ux2IzPRWMM-qRVpVn~J4yFxvkqAs~Xp2cWg7AdT2PvrCERhLt4QQbFf-c44zf-~37jOeWr63p1gZ7KoQQ4hd~nXPDRjSa9N8cf0CmIZC6R9Zgilrz5kC45H4KWiZrw5fCYm7GR0RInFrPuAC4~rbpF-dZ1Ky3VWCjl3npS5gcyqhPZIOoTSiYebexXlELlrUdJ4qHiX-BfYDi3RRLKaDxFhBCt2ywuPgA__',
                        title: 'Parota',
                      ),
                      CategoryCard(
                        imagePath: 'https://s3-alpha-sig.figma.com/img/c320/ec94/f38e7de32fe1b0b561dafb51b4a123e2?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=gdVzCF674ukb9NEZ9ziBbkbIGRf-nNdP9WPflnc3e0EqbMRbJFZ2ulurD6spzO-0XNfPTaK8hAvbP~titYbvFS5JD3cNmyutGMx9YWpTNpM9kh0II3q10gpIrQlr7rKMYhwnchb-e~uVB6iKXdMJi6JyL0wMFpwipj0RaNS5H6AeXbUotDCzzxL7vnr3N~hqjTxwfT7~WekUKX1UpyIBFhVFnbpfD08Xn71lc5lNnkHWazGg6PqL2A6tIJQeUq4c1puWNTdIcgfEhLam5-B9bE~bSiDjhehqSJtU~kjNF3PatomSXS-aDalLFow943FUXRXN9KMbVDCLSG-YZKLBzQ__',
                        title: 'Ice\ncream',
                      ),
                      CategoryCard(
                        imagePath: 'https://s3-alpha-sig.figma.com/img/35d9/0673/08aa4fb27b80de19060792920bb1ff80?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rDkTew0sHKHuCsmylH1ZyGW-8CQVzfoCQ3yMOfKy6-iZ3GyjOrBKeZxYJPOySqm26DH~an~8VC3BA2wzqaLIXbgZuhCU4N2JOoZZTxYd8KolcsJ2ZmsWh9Ucn~rCFYX-idTQ8T~WJfeP3WStfHkwCNy9G191boBUr41gBjRhtW5Q~zcDzICrfUZbov0Jqq5AT3ASwy57Ujae4nz2rDb65lFYeknK8mvNcyftvOkxnS~8MMrPycKDGyX4YMi4QyQO1PPoMMuhDaTu5EBkjHn8WnZTjn0m1OVdTzBWZXvby~1fCp9BWiOmUSIzc3xq2a7t6MaFzG9Q-sdY076T9~EE3w__',
                        title: 'Shakes',
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Promotional banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFFBF9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Order your favorite',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'food!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 36,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: const Text('Order now'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.network(
                        'https://s3-alpha-sig.figma.com/img/b479/e7b2/fc8d6e402d1159c888e53ce17aff5f2f?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Nm4kLB3cgzubBGIRjrXbfHtOFQaLjmpKk7KCtEghTIPojyb2fg-US9~SjRfkSvH9ag9LED4bzBdqCK3ur0uxLnnxJLGCqZPccYqjPy3KgMHHVHLN-VMgvAQ8aC9NVJM9Mvfd5kSdOHQsUf1HrjbuREHcYtnqVQRe7mQav7fxJm2kpJwfNmbM1TEaLn~o5PkyfeSN-JSSGTrqfo3Mtk6jusroxGV0qCcrBivFZ-3mcdZbw0w5qP-Khj9Gtt4wkpyobN98A~ul1ING-ovsJ6N87TzIELF3YogRg9ESyla9xHdm4rC-NfzA3I6-7LxWezpciHC-K8ozHu9JLyBWOvyjgg__',
                        width: 100,
                        height: 85,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Nearby restaurants header
                Row(
                  children: [
                    const Text(
                      'Nearby restaurants',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child:  Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RecommendedScreen()));
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(color: Colors.black87, fontSize: 14),
                            ),
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
                ),
                
                const SizedBox(height: 10),
                
                // Restaurant cards
                Row(
                  children: [
                    Expanded(
                      child: RestaurantCard(
                        imagePath: 
                        'https://static.vecteezy.com/system/resources/previews/015/933/659/non_2x/a-dosa-also-called-dosai-dosey-or-dosha-is-a-thin-pancake-in-south-indian-cuisine-free-photo.jpg',
                        name: 'Dosa Plaza',
                        rating: 4.2,
                        
                        description: 'All types of dosa',
                        price: 199,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RestaurantCard(
                        imagePath: 
                        'https://static.vecteezy.com/system/resources/previews/015/933/659/non_2x/a-dosa-also-called-dosai-dosey-or-dosha-is-a-thin-pancake-in-south-indian-cuisine-free-photo.jpg',
                        name: 'Radha Kitchen',
                        rating: 4.2,
                        description: 'Burgers, French fries',
                        price: 199,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Top restaurants header
                Row(
                  children: [
                    const Text(
                      'Top restaurants in Kakinada',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
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
                ),
                
                const SizedBox(height: 10),
                
                // Top restaurant cards
                Row(
                  children: [
                    Expanded(
                      child: RestaurantCard(
                        imagePath: 
                        'https://static.vecteezy.com/system/resources/previews/015/933/659/non_2x/a-dosa-also-called-dosai-dosey-or-dosha-is-a-thin-pancake-in-south-indian-cuisine-free-photo.jpg',
                        name: 'Dosa Plaza',
                        rating: 4.2,
                        description: 'All types of dosa',
                        price: null, // No price shown in this section
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RestaurantCard(
                        imagePath: 
                        'https://static.vecteezy.com/system/resources/previews/015/933/659/non_2x/a-dosa-also-called-dosai-dosey-or-dosha-is-a-thin-pancake-in-south-indian-cuisine-free-photo.jpg',
                        name: 'Radha Kitchen',
                        rating: 4.2,
                        description: 'Burgers, French fries',
                        price: null, 
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const CategoryCard({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFBF9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(imagePath),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final double rating;
  final String description;
  final int? price;

  const RestaurantCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.description,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant image with favorite button
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  imagePath,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.favorite_border,
                      size: 18,
                    ),
                  ),
                ),
              ),
              if (price != null)
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Starting at ₹$price',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          // Restaurant details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}