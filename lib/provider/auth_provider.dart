import 'package:flutter/material.dart';
import 'package:veegify/services/auth_service.dart';
import 'package:veegify/views/otp_screen.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _authService.register(
          firstName: firstName, lastName: lastName, phone: phone, email: email);
          Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => ScreenOtp()),
);

    } catch (e) {
      print("Registration Failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Failed: $e")),
      );
    }
  }
}
