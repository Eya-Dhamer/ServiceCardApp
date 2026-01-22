import 'package:app_7/providers/auth_provider.dart';
import 'package:app_7/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    return Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(32)),
      ),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person_rounded, color: AppTheme.primaryColor),
            ),
            accountName: Text(
              auth.userName ?? "Guest User",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(auth.email ?? "no-email@example.com"),
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(32),
              ),
            ),
          ),
          _buildDrawerTile(
            context,
            icon: Icons.home_rounded,
            title: "Home",
            onTap: () => GoRouter.of(context).go('/home'),
          ),
          _buildDrawerTile(
            context,
            icon: Icons.calendar_today_rounded,
            title: "My Bookings",
            onTap: () => GoRouter.of(context).push('/bookings'),
          ),
          _buildDrawerTile(
            context,
            icon: Icons.person_rounded,
            title: "Profile",
            onTap: () => context.push('/profile'),
          ),
          const Divider(indent: 20, endIndent: 20),
          _buildDrawerTile(
            context,
            icon: Icons.settings_rounded,
            title: "Settings",
            onTap: () => context.push('/settings'),
          ),
          _buildDrawerTile(
            context,
            icon: Icons.help_outline_rounded,
            title: "Help Center",
            onTap: () => context.push('/help'),
          ),
          const Spacer(),
          _buildDrawerTile(
            context,
            icon: Icons.logout_rounded,
            title: "Logout",
            color: Colors.redAccent,
            onTap: () async {
              // Show dialog immediately without closing drawer first
              // to keep the context stable.
              final shouldLogout = await showDialog<bool>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext dialogContext) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(true),
                      child: const Text("Logout", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );

              if (shouldLogout == true) {
                // Close the drawer now
                if (context.mounted) {
                  Navigator.of(context).pop(); 
                }
                // Perform logout. The router's refreshListenable will trigger redirection.
                await ref.read(authProvider.notifier).logout();
              }
            },
            isLogout: true, // Special flag to handle drawer popping
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
    bool isLogout = false,
  }) {
    final effectiveTextColor = color ?? Theme.of(context).textTheme.bodyLarge?.color ?? AppTheme.textColor;
    return ListTile(
      leading: Icon(icon, color: effectiveTextColor),
      title: Text(
        title,
        style: TextStyle(
          color: effectiveTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        if (!isLogout) {
          Navigator.pop(context); // Close drawer for normal navigation
        }
        onTap();
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }
}
