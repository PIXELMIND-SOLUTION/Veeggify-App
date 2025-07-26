import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationServicesssss {
  final String baseUrl = 'https://vegifyy-backend-2.onrender.com/api';

  // Add location to server
  Future<bool> addLocation(String userId, String latitude, String longitude) async {
    try {
            print('heloooooooooooooooooooooooooooooooooooohhhhhhhhhhhhhhhhhhhhhhhhhhhhh$userId');

      print('heloooooooooooooooooooooooooooooooooooohhhhhhhhhhhhhhhhhhhhhhhhhhhhh$latitude');
            print('heloooooooooooooooooooooooooooooooooooohhhhhhhhhhhhhhhhhhhhhhhhhhhhh$longitude');

      final response = await http.post(
        Uri.parse('$baseUrl/location/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'latitude': double.parse(latitude), 
          'longitude': double.parse(longitude)
        }),
      );

            print('heloooooooooooooooooooooooooooooooooooohhhhhhhhhhhhhhhhhhhhhhhhhhhhh${response.statusCode}');


      if (response.statusCode == 200 || response.statusCode == 200) {
        return true;
      } else {
        print('Failed to add location. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error adding location: $e');
      return false;
    }
  }
}