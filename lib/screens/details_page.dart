import 'package:app_7/models/service.dart';
import 'package:app_7/providers/booking_provider.dart';
import 'package:app_7/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DetailsPage extends ConsumerWidget {
  final Service service;

  const DetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
                  onPressed: () {
                    if (GoRouter.of(context).canPop()) {
                      GoRouter.of(context).pop();
                    } else {
                      GoRouter.of(context).go('/home');
                    }
                  },
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'service_image_${service.id}',
                child: Image.network(
                  service.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          service.category,
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ).animate().fadeIn().slideX(),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: AppTheme.accentColor, size: 24),
                          const SizedBox(width: 4),
                          Text(
                            service.rating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 200.ms),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    service.title,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 28,
                        ),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 8),
                  Text(
                    "Service by ${service.provider}",
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 24),
                  const Text(
                    "About this Service",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    service.description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ).animate().fadeIn(delay: 500.ms),
                  const SizedBox(height: 100), // Space for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Price",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  "\$${service.price}",
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Immediate Booking Logic
                  ref.read(bookingProvider.notifier).addBooking(service);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${service.title} booked successfully!"),
                      backgroundColor: AppTheme.secondaryColor,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  
                  GoRouter.of(context).push('/bookings');
                },
                child: const Text("Book Now"),
              ),
            ),
          ],
        ),
      ).animate().slideY(begin: 1, end: 0, delay: 600.ms),
    );
  }
}
