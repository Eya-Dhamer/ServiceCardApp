import 'package:app_7/providers/auth_provider.dart';
import 'package:app_7/providers/booking_provider.dart';
import 'package:app_7/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final bookings = ref.watch(bookingProvider);

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? null : Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        backgroundColor: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                        child: const Icon(Icons.person_rounded, size: 80, color: AppTheme.primaryColor),
                      ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppTheme.primaryColor,
                        child: const Icon(Icons.camera_alt_rounded, size: 18, color: Colors.white),
                      ).animate().fadeIn(delay: 400.ms),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    auth.userName ?? "Guest User",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 4),
                  Text(
                    auth.email ?? "no-email@example.com",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatCard("Bookings", bookings.length.toString()),
                      const SizedBox(width: 24),
                      _buildStatCard("Reviews", "12"),
                      const SizedBox(width: 24),
                      _buildStatCard("Level", "Gold"),
                    ],
                  ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Profile Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildOptionTile(context, Icons.edit_outlined, "Edit Profile", () => context.push('/profile/edit')),
                  _buildOptionTile(context, Icons.payment_outlined, "Payment Methods", () => context.push('/profile/payment')),
                  _buildOptionTile(context, Icons.notifications_none_rounded, "Notifications", () => context.push('/profile/notifications')),
                  _buildOptionTile(context, Icons.security_rounded, "Security", () => context.push('/profile/security')),
                  _buildOptionTile(context, Icons.share_outlined, "Refer a Friend", () => context.push('/profile/refer')),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildOptionTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
