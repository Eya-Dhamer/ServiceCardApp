import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_7/models/service.dart';

class BookingNotifier extends StateNotifier<List<Service>> {
  BookingNotifier() : super([]);

  void addBooking(Service service) {
    if (!state.any((s) => s.id == service.id)) {
      state = [...state, service];
    }
  }

  void removeBooking(String serviceId) {
    state = state.where((s) => s.id != serviceId).toList();
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, List<Service>>((ref) {
  return BookingNotifier();
});
