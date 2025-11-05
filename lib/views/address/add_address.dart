
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:veegify/helper/address_utils.dart';
import 'package:veegify/model/address_model.dart';
import 'package:veegify/provider/address_provider.dart';
import 'package:veegify/views/address/location_picker.dart' show LocationPickerScreen;
// Import your LocationPickerScreen
// import 'location_picker_screen.dart';

class AddAddress extends StatefulWidget {
  final Address? address; // For editing existing address
  
  const AddAddress({super.key, this.address});
  
  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _countryController;
  late TextEditingController _postalCodeController;
  
  String _selectedAddressType = 'Home';
  final List<String> _addressTypes = ['Home', 'Work', 'Office', 'Other'];
  
  bool _isLoading = false;
  String _selectedLocation = 'Tap to choose location';
  LatLng? _selectedLatLng;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize controllers with existing data if editing
    _streetController = TextEditingController(text: widget.address?.street ?? '');
    _cityController = TextEditingController(text: widget.address?.city ?? '');
    _stateController = TextEditingController(text: widget.address?.state ?? '');
    _countryController = TextEditingController(text: widget.address?.country ?? '');
    _postalCodeController = TextEditingController(text: widget.address?.postalCode ?? '');
    
    if (widget.address != null) {
      _selectedAddressType = widget.address!.addressType;
      // If editing and address has coordinates, set them
      if (widget.address!.lat != null && widget.address!.lng != null) {
        _selectedLatLng = LatLng(widget.address!.lat!, widget.address!.lng!);
        _selectedLocation = widget.address!.fullAddress ?? 'Selected location';
      }
    }
  }
  
  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  Future<void> _openLocationPicker() async {
    // Navigate to location picker screen
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(
          isEditing: widget.address != null,
          userId: 'current_user_id', // Replace with actual user ID
        ),
      ),
    );

    if (result != null) {
      final LatLng location = result['location'];
      final String fullAddress = result['address'];
      
      setState(() {
        _selectedLatLng = location;
        _selectedLocation = fullAddress;
      });

      // Parse and auto-fill address fields
      _parseAndFillAddress(fullAddress);
    }
  }

  void _parseAndFillAddress(String fullAddress) {
    try {
      // Use the AddressParser utility for better parsing
      Map<String, String> addressComponents = AddressParser.parseFullAddress(fullAddress);
      
      setState(() {
        _streetController.text = addressComponents['street'] ?? '';
        _cityController.text = addressComponents['city'] ?? '';
        _stateController.text = addressComponents['state'] ?? '';
        _countryController.text = addressComponents['country'] ?? '';
        _postalCodeController.text = addressComponents['postalCode'] ?? '';
      });
    } catch (e) {
      print('Error parsing address: $e');
      // Fallback to simple parsing
      List<String> parts = fullAddress.split(', ');
      if (parts.isNotEmpty) {
        setState(() {
          _streetController.text = parts.first.trim();
          if (parts.length > 1) _cityController.text = parts[1].trim();
          if (parts.length > 2) _stateController.text = parts[2].trim();
          if (parts.length > 3) _countryController.text = parts.last.trim();
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final isEditing = widget.address != null;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? 'Edit Address' : 'Add Address',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Choose Location Field
              const Text(
                'Choose Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _openLocationPicker,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: _selectedLatLng != null ? Colors.orange : Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _selectedLocation,
                          style: TextStyle(
                            fontSize: 16,
                            color: _selectedLatLng != null ? Colors.black87 : Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),

              // Address Type Dropdown
              const Text(
                'Address Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedAddressType,
                    isExpanded: true,
                    items: _addressTypes
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedAddressType = value;
                        });
                      }
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Street Address Field
              _buildTextField(
                label: 'Street Address',
                controller: _streetController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter street address';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // City Field
              _buildTextField(
                label: 'City',
                controller: _cityController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter city';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // State and Postal Code Row
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'State',
                      controller: _stateController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter state';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      label: 'Postal Code',
                      controller: _postalCodeController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter postal code';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Country Field
              _buildTextField(
                label: 'Country',
                controller: _countryController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter country';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 32),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          isEditing ? 'Update Address' : 'Save Address',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Cancel Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: _isLoading ? null : () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
        ),
      ],
    );
  }
  
  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      final addressProvider = Provider.of<AddressProvider>(context, listen: false);
      
      final address = Address(
        id: widget.address?.id, // Keep existing id if editing
        street: _streetController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        country: _countryController.text.trim(),
        postalCode: _postalCodeController.text.trim(),
        addressType: _selectedAddressType,
        lat: _selectedLatLng?.latitude,
        lng: _selectedLatLng?.longitude,
        fullAddress: _selectedLatLng != null ? _selectedLocation : null,
      );
      
      print('Saving address: ${address.toJson()}'); // Debug print
      
      bool success;
      if (widget.address != null) {
              print('Saving addressssssssssssssssss'); // Debug print

        // Update existing address
        success = await addressProvider.updateAddress(widget.address!.id!, address);
      } else {
                      print('Saving addressssssssssssssssss1111111111'); // Debug print

        // Add new address
        success = await addressProvider.addAddress(address);
      }
      
      print('Save operation success: $success'); // Debug print
      
      if (mounted) {
        if (success) {
          Navigator.pop(context, true); // Return true to indicate success
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(addressProvider.errorMessage.isNotEmpty 
                  ? addressProvider.errorMessage 
                  : 'Failed to save address'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('Exception in _saveAddress: $e'); // Debug print
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving address: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}