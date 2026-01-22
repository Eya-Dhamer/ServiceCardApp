import 'package:app_7/models/service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/myform.dart';

class Subscribe extends StatelessWidget {
  final Service service;
  const Subscribe({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book a Service"),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking ${service.title}",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 24,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please provide your contact information to complete the booking for ${service.provider}'s service.",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 32),
            Myform(service: service),
          ],
        ),
      ),
    );
  }
}
