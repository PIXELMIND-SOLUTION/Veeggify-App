import 'package:flutter/material.dart';
import 'package:veegify/provider/cart_provider.dart';

// Booking model to store cart data
class Booking {
  final String id;
  final List<CartItem> items;
  final int subtotal;
  final int deliveryCharge;
  final int totalPayable;
  final int totalItems;
  final DateTime bookingDate;
  final String status; // 'today', 'completed', 'cancelled'

  Booking({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.deliveryCharge,
    required this.totalPayable,
    required this.totalItems,
    required this.bookingDate,
    this.status = 'today',
  });

  // Copy with method to update status
  Booking copyWith({
    String? id,
    List<CartItem>? items,
    int? subtotal,
    int? deliveryCharge,
    int? totalPayable,
    int? totalItems,
    DateTime? bookingDate,
    String? status,
  }) {
    return Booking(
      id: id ?? this.id,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      totalPayable: totalPayable ?? this.totalPayable,
      totalItems: totalItems ?? this.totalItems,
      bookingDate: bookingDate ?? this.bookingDate,
      status: status ?? this.status,
    );
  }
}


class BookingProvider with ChangeNotifier {
  final List<Booking> _bookings = [];

  List<Booking> get allBookings => _bookings;

  // Get today's bookings
  List<Booking> get todayBookings {
    final today = DateTime.now();
    return _bookings.where((booking) {
      return booking.bookingDate.year == today.year &&
             booking.bookingDate.month == today.month &&
             booking.bookingDate.day == today.day &&
             booking.status == 'today';
    }).toList();
  }

  // Get completed bookings
  List<Booking> get completedBookings {
    return _bookings.where((booking) => booking.status == 'completed').toList();
  }

  // Get cancelled bookings
  List<Booking> get cancelledBookings {
    return _bookings.where((booking) => booking.status == 'cancelled').toList();
  }

  // Add booking from cart data
  void addBookingFromCart({
    required List<CartItem> cartItems,
    required int subtotal,
    required int deliveryCharge,
    required int totalPayable,
    required int totalItems,
  }) {
    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(cartItems), // Create a copy of cart items
      subtotal: subtotal,
      deliveryCharge: deliveryCharge,
      totalPayable: totalPayable,
      totalItems: totalItems,
      bookingDate: DateTime.now(),
      status: 'today',
    );

    _bookings.add(booking);
    notifyListeners();
  }

  // Update booking status
  void updateBookingStatus(String bookingId, String newStatus) {
    final bookingIndex = _bookings.indexWhere((booking) => booking.id == bookingId);
    if (bookingIndex != -1) {
      _bookings[bookingIndex] = _bookings[bookingIndex].copyWith(status: newStatus);
      notifyListeners();
    }
  }

  // Cancel booking
  void cancelBooking(String bookingId) {
    updateBookingStatus(bookingId, 'cancelled');
  }

  // Complete booking
  void completeBooking(String bookingId) {
    updateBookingStatus(bookingId, 'completed');
  }

  // Get booking by ID
  Booking? getBookingById(String id) {
    try {
      return _bookings.firstWhere((booking) => booking.id == id);
    } catch (e) {
      return null;
    }
  }

  // Remove booking
  void removeBooking(String bookingId) {
    _bookings.removeWhere((booking) => booking.id == bookingId);
    notifyListeners();
  }

  // Clear all bookings
  void clearAllBookings() {
    _bookings.clear();
    notifyListeners();
  }
}