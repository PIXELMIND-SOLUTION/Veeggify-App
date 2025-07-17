// import 'package:flutter/material.dart';
// import 'package:veegify/helper/storage_helper.dart';
// import 'package:veegify/model/user_model.dart';
// import 'package:veegify/services/auth_service.dart';
// import 'package:veegify/views/create_password.dart';
// import 'package:veegify/views/login_page.dart';
// import 'package:veegify/views/otp_screen.dart';
// import 'package:veegify/views/home/navbar_screen.dart';

// class AuthProvider with ChangeNotifier {
//   final AuthService _authService = AuthService();

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   String? _token;
//   String? get token => _token;

//   User? _currentUser;
//   User? get currentUser => _currentUser;

//   Future<void> register({
//     required String firstName,
//     required String lastName,
//     required String phone,
//     required String email,
//     String? referalCode,
//     required BuildContext context,
//   }) async {
//     try {
//       _isLoading = true;
//       notifyListeners();

//       final response = await _authService.register(
//           firstName: firstName, lastName: lastName, phone: phone, email: email, referalCode: referalCode);
      
//       // Store the token for OTP verification
//       _token = response['token'];
      
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => ScreenOtp()),
//       );

//     } catch (e) {
//       print("Registration Failed: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Registration Failed: $e")),
//       );
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> login({
//     required String phoneNumber,
//     required String password,
//     required bool rememberMe,
//     required BuildContext context,
//   }) async {
//     try {
//       _isLoading = true;
//       notifyListeners();

//       final response = await _authService.login(
//         phoneNumber: phoneNumber,
//         password: password,
//       );

//       // Create user object from response
//       _currentUser = User.fromJson(response['user']);
      
//       // Save user data to SharedPreferences
//       await UserPreferences.saveUser(_currentUser!);
      
//       // Save remember me preference
//       await UserPreferences.saveRememberMe(rememberMe);
      
//       if (rememberMe) {
//         await UserPreferences.savePhoneNumber(phoneNumber);
//         await UserPreferences.savePassword(password);
//       }

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(response['message'] ?? "Login successful!"),
//           backgroundColor: Colors.green,
//         ),
//       );

//       // Navigate to home screen
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (_) => NavbarScreen()),
//         (route) => false,
//       );

//     } catch (e) {
//       print("Login Failed: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Login Failed: $e")),
//       );
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> logout(BuildContext context) async {
//     try {
//       _isLoading = true;
//       notifyListeners();

//       // Clear user data from SharedPreferences
//       await UserPreferences.clearUserData();
      
//       // Clear current user
//       _currentUser = null;
//       _token = null;

//       // Navigate to login screen
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         '/login',
//         (route) => false,
//       );

//     } catch (e) {
//       print("Logout Failed: $e");
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> checkLoginStatus() async {
//     if (UserPreferences.isLoggedIn()) {
//       _currentUser = UserPreferences.getUser();
//       notifyListeners();
//     }
//   }

//   Future<void> verifyOtp({
//     required String otp,
//     required BuildContext context,
//   }) async {
//     if (_token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Token not found. Please register again.")),
//       );
//       return;
//     }

//     try {
//       _isLoading = true;
//       notifyListeners();

//       final response = await _authService.verifyOtp(
//         otp: otp,
//         token: _token!,
//       );

//       // Navigate to CreatePassword screen with userId
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => CreatePassword(userId: response['userId']),
//         ),
//       );

//     } catch (e) {
//       print("OTP Verification Failed: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("OTP Verification Failed: $e")),
//       );
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> setPassword({
//     required String userId,
//     required String password,
//     required BuildContext context,
//   }) async {
//     try {
//       _isLoading = true;
//       notifyListeners();

//       await _authService.setPassword(
//         userId: userId,
//         password: password,
//       );

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Password created successfully!"),
//           backgroundColor: Colors.green,
//         ),
//       );

//       // Navigate to login screen and remove all previous routes
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => LoginPage(),
//         ),
//       );

//     } catch (e) {
//       print("Password Creation Failed: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Password Creation Failed: $e")),
//       );
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }









import 'package:flutter/material.dart';
import 'package:veegify/helper/storage_helper.dart';
import 'package:veegify/helper/toast_helper.dart';
import 'package:veegify/model/user_model.dart';
import 'package:veegify/services/auth_service.dart';
import 'package:veegify/views/create_password.dart';
import 'package:veegify/views/login_page.dart';
import 'package:veegify/views/otp_screen.dart';
import 'package:veegify/views/home/navbar_screen.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;

  User? _currentUser;
  User? get currentUser => _currentUser;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    String? referalCode,
    required BuildContext context,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final response = await _authService.register(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        referalCode: referalCode,
      );

      // Store the token for OTP verification
      _token = response['token'];

      // Show success message
      ToastHelper.showSuccessToast('Registration successful! Please verify your OTP.');

      // Navigate to OTP screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ScreenOtp()),
      );
    } on ValidationException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } on NetworkException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } on AuthException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } catch (e) {
      final errorMessage = 'Registration failed: ${e.toString()}';
      _setError(errorMessage);
      ToastHelper.showErrorToast(errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> login({
    required String phoneNumber,
    required String password,
    required bool rememberMe,
    required BuildContext context,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final response = await _authService.login(
        phoneNumber: phoneNumber,
        password: password,
      );

      // Create user object from response
      _currentUser = User.fromJson(response['user']);

      // Save user data to SharedPreferences
      await UserPreferences.saveUser(_currentUser!);

      // Save remember me preference
      await UserPreferences.saveRememberMe(rememberMe);

      if (rememberMe) {
        await UserPreferences.savePhoneNumber(phoneNumber);
        await UserPreferences.savePassword(password);
      }

      // Show success message
      ToastHelper.showSuccessToast(
        response['message'] ?? 'Login successful!',
      );

      // Navigate to home screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => NavbarScreen()),
        (route) => false,
      );
    } on ValidationException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } on NetworkException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } on AuthException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } catch (e) {
      final errorMessage = 'Login failed: ${e.toString()}';
      _setError(errorMessage);
      ToastHelper.showErrorToast(errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      _setLoading(true);
      _setError(null);

      // Clear user data from SharedPreferences
      await UserPreferences.clearUserData();

      // Clear current user and token
      _currentUser = null;
      _token = null;

      ToastHelper.showSuccessToast('Logged out successfully');

      // Navigate to login screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );
    } catch (e) {
      final errorMessage = 'Logout failed: ${e.toString()}';
      _setError(errorMessage);
      ToastHelper.showErrorToast(errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> checkLoginStatus() async {
    try {
      if (UserPreferences.isLoggedIn()) {
        _currentUser = UserPreferences.getUser();
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to check login status: ${e.toString()}');
    }
  }

  Future<void> verifyOtp({
    required String otp,
    required BuildContext context,
  }) async {
    if (_token == null) {
      final errorMessage = 'Session expired. Please register again.';
      _setError(errorMessage);
      ToastHelper.showErrorToast(errorMessage);
      return;
    }

    try {
      _setLoading(true);
      _setError(null);

      final response = await _authService.verifyOtp(
        otp: otp,
        token: _token!,
      );

      ToastHelper.showSuccessToast('OTP verified successfully!');

      // Navigate to CreatePassword screen with userId
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CreatePassword(userId: response['userId']),
        ),
      );
    } on ValidationException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } on NetworkException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } on AuthException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } catch (e) {
      final errorMessage = 'OTP verification failed: ${e.toString()}';
      _setError(errorMessage);
      ToastHelper.showErrorToast(errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> setPassword({
    required String userId,
    required String password,
    required BuildContext context,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      await _authService.setPassword(
        userId: userId,
        password: password,
      );

      ToastHelper.showSuccessToast('Password created successfully!');

      // Navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginPage(),
        ),
      );
    } on ValidationException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } on NetworkException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } on AuthException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } catch (e) {
      final errorMessage = 'Password creation failed: ${e.toString()}';
      _setError(errorMessage);
      ToastHelper.showErrorToast(errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    if (_token == null) {
      final errorMessage = 'Session expired. Please register again.';
      _setError(errorMessage);
      ToastHelper.showErrorToast(errorMessage);
      return;
    }

    try {
      _setLoading(true);
      _setError(null);

      await _authService.resendOtp(token: _token!);

      ToastHelper.showSuccessToast('OTP resent successfully!');
    } on ValidationException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } on NetworkException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } on AuthException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } catch (e) {
      final errorMessage = 'Failed to resend OTP: ${e.toString()}';
      _setError(errorMessage);
      ToastHelper.showErrorToast(errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> forgotPassword({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      await _authService.forgotPassword(phoneNumber: phoneNumber);

      ToastHelper.showSuccessToast('Password reset instructions sent!');
    } on ValidationException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } on NetworkException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } on AuthException catch (e) {
      _setError(e.message);
      ToastHelper.showErrorToast(e.message);
    } catch (e) {
      final errorMessage = 'Failed to reset password: ${e.toString()}';
      _setError(errorMessage);
      ToastHelper.showErrorToast(errorMessage);
    } finally {
      _setLoading(false);
    }
  }
}