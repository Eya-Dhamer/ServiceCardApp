import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isInitializing;
  final String? userName;
  final String? email;

  AuthState({
    required this.isAuthenticated,
    this.isInitializing = false,
    this.userName,
    this.email,
  });

  factory AuthState.unauthenticated() => AuthState(isAuthenticated: false);
  factory AuthState.initializing() => AuthState(isAuthenticated: false, isInitializing: true);
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initializing()) {
    checkAuthState();
  }

  Future<void> checkAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      final email = prefs.getString('userEmail') ?? "eya@example.com";
      final name = prefs.getString('userName_$email') ?? "Eya Dhamer";
      state = AuthState(
        isAuthenticated: true,
        userName: name,
        email: email,
      );
    } else {
      state = AuthState.unauthenticated();
    }
  }

  Future<void> login(String email, String password) async {
    // Mock login logic
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    // In a real app, you'd fetch the name based on email
    final name = prefs.getString('userName_$email') ?? "Eya Dhamer";
    
    state = AuthState(
      isAuthenticated: true,
      userName: name,
      email: email,
    );
  }

  Future<void> register(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    // Persist registration info locally for search mock
    await prefs.setString('userName_$email', name);
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    
    state = AuthState(
      isAuthenticated: true,
      userName: name,
      email: email,
    );
  }

  Future<void> logout() async {
    print("AUTH: Initiating logout...");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    state = AuthState.unauthenticated();
    print("AUTH: Logout complete. State: unauthenticated");
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
