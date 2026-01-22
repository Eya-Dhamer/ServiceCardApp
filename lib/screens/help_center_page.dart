import 'package:app_7/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Help Center"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Search Bar for Help
            TextField(
              decoration: InputDecoration(
                hintText: "Search for help...",
                prefixIcon: const Icon(Icons.search_rounded),
                fillColor: Colors.grey.shade100,
                hintStyle: TextStyle(color: Colors.grey.shade400),
              ),
            ).animate().fadeIn().slideY(begin: 0.1, end: 0),
            
            const SizedBox(height: 32),
            _buildSectionHeader(context, "Contact Support"),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildContactCard(Icons.chat_bubble_outline_rounded, "Live Chat"),
                const SizedBox(width: 16),
                _buildContactCard(Icons.email_outlined, "Email Us"),
              ],
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 32),
            _buildSectionHeader(context, "Frequently Asked Questions"),
            const SizedBox(height: 16),
            _buildFAQTile("How do I book a service?", "You can book a service by selecting one from the home screen and clicking the 'Book Now' button."),
            _buildFAQTile("Can I cancel a booking?", "Yes, you can cancel your booking from the 'My Bookings' section up to 24 hours before the service."),
            _buildFAQTile("What payment methods are supported?", "We support credit cards, Apple Pay, and Google Pay."),
            _buildFAQTile("How do I contact a service provider?", "Once a booking is confirmed, their contact details will appear in the booking details."),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: 32),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQTile(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer, style: TextStyle(color: Colors.grey.shade600, height: 1.5)),
          ),
        ],
      ),
    );
  }
}
