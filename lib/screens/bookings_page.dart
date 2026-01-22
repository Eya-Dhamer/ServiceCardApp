import 'package:app_7/providers/booking_provider.dart';
import 'package:app_7/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookingsPage extends ConsumerWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookedServices = ref.watch(bookingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
        leading: IconButton(
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            } else {
              GoRouter.of(context).go('/home');
            }
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: bookedServices.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No bookings yet",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Your booked services will appear here.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => GoRouter.of(context).go('/home'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text("Explore Services"),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: bookedServices.length,
              itemBuilder: (context, index) {
                final service = bookedServices[index];
                return ServiceCard(
                  service: service,
                  onTap: () {
                    GoRouter.of(context).push('/details', extra: service);
                  },
                );
              },
            ),
    );
  }
}
