

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/model/address_model.dart';
import 'package:veegify/provider/address_provider.dart';
import 'package:veegify/views/address/add_address.dart';


class AddressList extends StatefulWidget {
  const AddressList({super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  void initState() {
    super.initState();
    // Load addresses when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressProvider>().loadAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Addresses',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.refresh, color: Colors.black),
        //     onPressed: () {
        //       context.read<AddressProvider>().refreshAddresses();
        //     },
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Add Address Button
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const AddAddress())
                  );
                  
                  // Refresh the list if an address was added
                  if (result == true) {
                    context.read<AddressProvider>().refreshAddresses();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Add address',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Address List
            Expanded(
              child: Consumer<AddressProvider>(
                builder: (context, addressProvider, child) {
                  if (addressProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 33, 65, 243),
                      ),
                    );
                  }

                  if (addressProvider.errorMessage.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            addressProvider.errorMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red[600],
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              addressProvider.refreshAddresses();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (addressProvider.addresses.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_off,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No addresses found',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Add your first address to get started',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: addressProvider.addresses.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final address = addressProvider.addresses[index];
                      return _buildAddressCard(context, address, addressProvider);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, Address address, AddressProvider provider) {
    return Container(
      width: double.infinity,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Location Icon
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 2),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black54,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Address Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        address.addressType,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.black54,
                          size: 20,
                        ),
                        onSelected: (value) async {
                          if (value == 'edit') {
                            // Navigate to edit address
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddAddress(address: address),
                              ),
                            );
                            if (result == true) {
                              provider.refreshAddresses();
                            }
                          } else if (value == 'delete') {
                            _showDeleteConfirmation(context, address, provider);
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 18),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 18, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Delete', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    textAlign: TextAlign.justify,
                    address.street,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _showDeleteConfirmation(BuildContext context, Address address, AddressProvider provider) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Delete Address'),
  //         content: Text('Are you sure you want to delete "${address.addressType}" address?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               Navigator.of(context).pop();
  //               final success = await provider.removeAddress(address.id!);
                
  //               if (success) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(
  //                     content: Text('Address deleted successfully'),
  //                     backgroundColor: Colors.green,
  //                   ),
  //                 );
  //               } else {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(
  //                     content: Text(provider.errorMessage),
  //                     backgroundColor: Colors.red,
  //                   ),
  //                 );
  //               }
  //             },
  //             child: const Text(
  //               'Delete',
  //               style: TextStyle(color: Colors.red),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

//   void _showDeleteConfirmation(BuildContext parentContext, Address address, AddressProvider provider) {
//   showDialog(
//     context: parentContext,
//     builder: (BuildContext dialogContext) {
//       return AlertDialog(
//         title: const Text('Delete Address'),
//         content: Text('Are you sure you want to delete "${address.addressType}" address?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(dialogContext).pop(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.of(dialogContext).pop(); // Close the dialog first

//               // Delay slightly to make sure the dialog is fully removed
//               await Future.delayed(const Duration(milliseconds: 100));

//               final success = await provider.removeAddress(address.id!);

//               if (!mounted) return; // Ensure widget is still in tree

//               ScaffoldMessenger.of(parentContext).showSnackBar(
//                 SnackBar(
//                   content: Text(success
//                       ? 'Address deleted successfully'
//                       : provider.errorMessage),
//                   backgroundColor: success ? Colors.green : Colors.red,
//                 ),
//               );
//             },
//             child: const Text(
//               'Delete',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

void _showDeleteConfirmation(BuildContext parentContext, Address address, AddressProvider provider) {
  showDialog(
    context: parentContext,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Delete Address'),
        content: Text('Are you sure you want to delete "${address.addressType}" address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();

              final success = await provider.removeAddress(address.id!);

              // ✅ Show snackbar from parentContext after dialog is gone
              Future.delayed(Duration(milliseconds: 100), () {
                if (!parentContext.mounted) return;

                ScaffoldMessenger.of(parentContext).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? 'Address deleted successfully'
                        : provider.errorMessage),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
              });
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}


}