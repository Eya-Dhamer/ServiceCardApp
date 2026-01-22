import 'package:app_7/models/service.dart';
import 'package:app_7/providers/booking_provider.dart';
import 'package:app_7/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class Myform extends ConsumerStatefulWidget {
  final Service service;
  const Myform({super.key, required this.service});

  @override
  ConsumerState<Myform> createState() => _MyformState();
}

class _MyformState extends ConsumerState<Myform> {
  final _formKey = GlobalKey<FormState>();
  String? ville = 'Sfax';
  final items = ['Sfax', 'Tunis', 'Sousse', 'Gabes'];
  
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  bool _isObscure = true;
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        // Add service to bookings
        ref.read(bookingProvider.notifier).addBooking(widget.service);
        
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Booking request sent successfully!'),
            backgroundColor: AppTheme.secondaryColor,
          ),
        );
        GoRouter.of(context).go('/bookings');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTextField(
            controller: _nameController,
            label: "Full Name",
            hint: "Enter your full name",
            icon: Icons.person_rounded,
            validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _emailController,
            label: "Email Address",
            hint: "Enter your email",
            icon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) return 'Please enter your email';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _passwordController,
            label: "Password",
            hint: "Enter your password",
            icon: Icons.lock_rounded,
            obscureText: _isObscure,
            suffixIcon: IconButton(
              icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => _isObscure = !_isObscure),
            ),
            validator: (value) => value!.length < 6 ? 'Password too short' : null,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _phoneController,
            label: "Phone Number",
            hint: "Enter your phone number",
            icon: Icons.phone_rounded,
            keyboardType: TextInputType.phone,
            validator: (value) => value!.isEmpty ? 'Please enter your phone' : null,
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            initialValue: ville,
            decoration: const InputDecoration(
              labelText: "City",
              prefixIcon: Icon(Icons.location_city_rounded),
            ),
            items: items.map((city) {
              return DropdownMenuItem(value: city, child: Text(city));
            }).toList(),
            onChanged: (value) => setState(() => ville = value),
            borderRadius: BorderRadius.circular(16),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _isLoading ? null : _submitForm,
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : const Text("Confirm Booking"),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
