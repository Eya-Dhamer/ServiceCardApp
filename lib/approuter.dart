import 'package:app_7/models/service.dart';
import 'package:app_7/providers/auth_provider.dart';
import 'package:app_7/screens/bookings_page.dart';
import 'package:app_7/screens/details_page.dart';
import 'package:app_7/screens/home_page.dart';
import 'package:app_7/screens/login_page.dart';
import 'package:app_7/screens/subscribe.dart';
import 'package:app_7/screens/register_page.dart';
import 'package:app_7/screens/profile_page.dart';
import 'package:app_7/screens/settings_page.dart';
import 'package:app_7/screens/help_center_page.dart';
import 'package:app_7/screens/edit_profile_page.dart';
import 'package:app_7/screens/payment_methods_page.dart';
import 'package:app_7/screens/profile_util_pages.dart';
import 'package:app_7/screens/settings_sub_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A notifier that communicates Riverpod state changes to GoRouter.
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    // Rebuild the router whenever the auth state changes.
    _ref.listen<AuthState>(
      authProvider,
      (previous, next) {
        if (previous?.isAuthenticated != next.isAuthenticated || 
            previous?.isInitializing != next.isInitializing) {
          notifyListeners();
        }
      },
    );
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

final routerProvider = Provider<GoRouter>((ref) {
  // Use ref.read for the notifier to ensure the router instance itself is stable.
  // The refreshListenable will handle the re-evaluation of the redirect logic.
  final notifier = ref.read(routerNotifierProvider);

  return GoRouter(
    initialLocation: '/home',
    refreshListenable: notifier,
    debugLogDiagnostics: true, // Helpful for debugging
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/register';

      if (authState.isInitializing) {
        return null;
      }

      if (!authState.isAuthenticated) {
        if (isLoggingIn || isRegistering) return null;
        return '/login';
      }

      if (isLoggingIn || isRegistering) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/subscribe',
        name: 'subscribe',
        builder: (context, state) {
          final service = state.extra as Service?;
          if (service == null) return const HomePage();
          return Subscribe(service: service);
        },
      ),
      GoRoute(
        path: '/details',
        name: 'details',
        builder: (context, state) {
          final service = state.extra as Service?;
          if (service == null) return const HomePage();
          return DetailsPage(service: service);
        },
      ),
      GoRoute(
        path: '/bookings',
        name: 'bookings',
        builder: (context, state) => const BookingsPage(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/settings/privacy',
        name: 'privacy',
        builder: (context, state) => const PrivacyPolicyPage(),
      ),
      GoRoute(
        path: '/settings/terms',
        name: 'terms',
        builder: (context, state) => const TermsOfServicePage(),
      ),
      GoRoute(
        path: '/settings/about',
        name: 'about',
        builder: (context, state) => const AboutAppPage(),
      ),
      GoRoute(
        path: '/help',
        name: 'help',
        builder: (context, state) => const HelpCenterPage(),
      ),
      GoRoute(
        path: '/profile/edit',
        name: 'edit_profile',
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: '/profile/payment',
        name: 'payment_methods',
        builder: (context, state) => const PaymentMethodsPage(),
      ),
      GoRoute(
        path: '/profile/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationsSettingsPage(),
      ),
      GoRoute(
        path: '/profile/security',
        name: 'security',
        builder: (context, state) => const SecuritySettingsPage(),
      ),
      GoRoute(
        path: '/profile/refer',
        name: 'refer',
        builder: (context, state) => const ReferFriendPage(),
      ),
    ],
  );
});