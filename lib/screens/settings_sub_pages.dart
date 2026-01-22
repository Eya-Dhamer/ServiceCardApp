import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Last Updated: January 2026", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            Text(
              "Your privacy is important to us. This Privacy Policy explains how Benefit Services Pro collects, uses, and protects your information when you use our app.",
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 16),
            Text("1. Information We Collect", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
              "We collect information such as your name and email address when you create an account. This information is stored locally on your device and is used to personalize your experience.",
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 16),
            Text("2. How We Use Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
              "Your information is used purely for app functionality, such as managing your bookings and profile settings. We do not sell your personal data to third parties.",
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 16),
            Text("3. Data Security", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
              "We use industry-standard security measures to protect your data. However, no method of transmission over the internet or electronic storage is 100% secure.",
              style: TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms of Service")),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome to Benefit Services Pro!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text(
              "By using our application, you agree to comply with and be bound by the following terms and conditions of use.",
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 24),
            Text("1. Use of the App", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              "The content of the pages of this app is for your general information and use only. It is subject to change without notice.",
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 16),
            Text("2. User Accounts", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              "You are responsible for maintaining the confidentiality of your account and password and for restricting access to your computer or mobile device.",
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 16),
            Text("3. Limitation of Liability", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              "Benefit Services Pro shall not be liable for any special or consequential damages that result from the use of, or the inability to use, the materials on this app.",
              style: TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("About App")),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Hero(
                tag: 'app_logo',
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.star_rounded, size: 60, color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Benefit Services Pro",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Version 1.0.4",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 48),
              const Text(
                "Your all-in-one solution for premium home and personal services. Built with Flutter for a fast and beautiful experience.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 64),
              const Divider(),
              const SizedBox(height: 24),
              const Text(
                "Developed by Eya Dhamer",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                "Built with ❤️ and Flutter",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
