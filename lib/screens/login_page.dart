import 'package:app_7/providers/auth_provider.dart';
import 'package:app_7/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "eya@example.com");
  final _passwordController = TextEditingController(text: "password123");
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      await ref.read(authProvider.notifier).login(
            _emailController.text,
            _passwordController.text,
          );
      if (mounted) {
        setState(() => _isLoading = false);
        context.go('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  // Logo or Icon
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.handyman_rounded,
                        size: 64,
                        color: AppTheme.primaryColor,
                      ),
                    ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Welcome Back",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 32,
                        ),
                  ).animate().fadeIn(delay: 200.ms).slideX(),
                  const SizedBox(height: 8),
                  Text(
                    "Sign in to continue exploring services",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ).animate().fadeIn(delay: 300.ms).slideX(),
                  const SizedBox(height: 48),
                  
                  // Form Fields
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (val) => val!.isEmpty ? "Enter email" : null,
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                    validator: (val) => val!.isEmpty ? "Enter password" : null,
                  ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
                  
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot Password?"),
                    ),
                  ).animate().fadeIn(delay: 600.ms),
                  
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Text("Sign In"),
                  ).animate().fadeIn(delay: 700.ms).scale(),
                  
                  const Spacer(),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => context.push('/register'),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 800.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
