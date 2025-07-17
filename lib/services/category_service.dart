import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:veegify/constants/api.dart'; 


class CategoryService {
  Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
  }) async {
    try {
      final url = Uri.parse(ApiConstants.register);

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to register user: ${response.body}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Something went wrong: $e');
    }
  }
}
