import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {

  final String baseUrl= "https://vegifyy-backend-2.onrender.com/api";
  Future <Map<String,dynamic>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
  })async{
    try{
      final url = Uri.parse('$baseUrl/register');
      final response = await http.post(
        url,
        headers: {'Content-Type':'application/json'},
        body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
        }
        ),
      );

      print("Statusssssssssssssssssssssssssss${response.statusCode}");
      

      print("Statusssssssssssssssssssssssssss${response.body}");

      if(response.statusCode==200){
          return jsonDecode(response.body);
      }else{
        throw Exception('Failed to register user');
      }
    }catch(e){
      print("Error$e");
      throw Exception('Something went wrong: $e');
    }
  }
}
