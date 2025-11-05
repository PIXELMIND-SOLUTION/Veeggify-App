// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  'https://www.whiskaffair.com/wp-content/uploads/2018/11/Vegetable-Fried-Rice-2-3.jpg', // Replace with your image asset
                  width: double.infinity,
                  height: 375,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,))),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Veg panner fried rice",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("🟢 Banguril junction, kakinada",
                      style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 4),
                  const Text("₹250",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoTile(Icons.star, "4.2", "Ratings"),
                      _infoTile(Icons.people, "1k+", "Ratings"),
                      _infoTile(Icons.timer, "15 min", "Delivery"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text("Description",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  const Text("Reviews",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _reviewCard("Manoj kumar", "kakinada", 4,
                      "Lorem Ipsum is simply dummy text of the printing"),
                  const SizedBox(height: 8),
                  _reviewCard("Manoj kumar", "kakinada", 5,
                      "Lorem Ipsum is simply dummy text of the printing"),
                ],
              ),
            ),

            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                    onPressed: () {
                         showModalBottomSheet(context: context,
                         isScrollControlled: true,
                         shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                         ),
                         builder: (context)=>BottomSheetContent());
                    },
                    child: const Text("Add to Cart"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                    onPressed: () {

                    },
                    child: const Text("Order Now"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String value, String label) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          Icon(icon, color: Colors.green, size: 20),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _reviewCard(String name, String location, int rating, String comment) {
    return Row(
      children: [
        const CircleAvatar(child: Icon(Icons.person)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      );
                    }),
                  )
                ],
              ),
              Text(location,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              const SizedBox(height: 4),
              Text(comment),
            ],
          ),
        )
      ],
    );
  }
}


class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  String _selectedVariation = 'Half';
  int _quantity = 1;
  Set<String> _selectedAddOns = {};
  int _basePrice = 225;

  final Map<String, int> variations = {'Half': 225, 'Full': 310};
  final Map<String, int> addOns = {'1 Plate': 5, '2 Plates': 10};

  int get totalPrice {
    int variationPrice = variations[_selectedVariation]!;
    int addOnTotal = _selectedAddOns.fold(0, (sum, key) => sum + addOns[key]!);
    return (variationPrice + addOnTotal) * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Veg panner fried rice", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

          const SizedBox(height: 16),
          const Align(alignment: Alignment.centerLeft, child: Text("Variation", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))),
          const SizedBox(height: 8),
          ...variations.entries.map((entry) => RadioListTile<String>(
                title: Text("${entry.key} ₹${entry.value}"),
                value: entry.key,
                groupValue: _selectedVariation,
                onChanged: (val) {
                  setState(() => _selectedVariation = val!);
                },
              )),

          const SizedBox(height: 8),
          const Align(alignment: Alignment.centerLeft, child: Text("Add on plate", style: TextStyle(fontWeight: FontWeight.bold),)),
          ...addOns.entries.map((entry) => CheckboxListTile(
                title: Text("${entry.key} +₹${entry.value}"),
                value: _selectedAddOns.contains(entry.key),
                onChanged: (checked) {
                  setState(() {
                    if (checked == true) {
                      if (_selectedAddOns.length < 2) {
                        _selectedAddOns.add(entry.key);
                      }
                    } else {
                      _selectedAddOns.remove(entry.key);
                    }
                  });
                },
              )),

          const SizedBox(height: 12),
          Row(
            children: [
              IconButton(
                onPressed: () => setState(() {
                  if (_quantity > 1) _quantity--;
                }),
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text("$_quantity", style: const TextStyle(fontSize: 18)),
              IconButton(
                onPressed: () => setState(() => _quantity++),
                icon: const Icon(Icons.add_circle_outline),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
            
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Add Item | ₹$totalPrice",style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ],
      ),
    );
  }
}





