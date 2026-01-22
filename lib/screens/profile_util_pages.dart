import 'package:app_7/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({super.key});

  @override
  State<NotificationsSettingsPage> createState() => _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  bool _bookingUpdates = true;
  bool _promotions = false;
  bool _serviceReminders = true;
  bool _appUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSwitchTile(
            "Booking Updates",
            "Get notified when a booking is confirmed",
            _bookingUpdates,
            (v) => setState(() => _bookingUpdates = v),
          ),
          _buildSwitchTile(
            "Promotions",
            "Special offers and discounts",
            _promotions,
            (v) => setState(() => _promotions = v),
          ),
          _buildSwitchTile(
            "Service Reminders",
            "Reminders for upcoming services",
            _serviceReminders,
            (v) => setState(() => _serviceReminders = v),
          ),
          _buildSwitchTile(
            "App Updates",
            "New features and improvements",
            _appUpdates,
            (v) => setState(() => _appUpdates = v),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }
}

class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  State<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  bool _biometricEnabled = true;

  void _showPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(decoration: InputDecoration(labelText: "Current Password")),
            const TextField(decoration: InputDecoration(labelText: "New Password")),
            const TextField(decoration: InputDecoration(labelText: "Confirm New Password")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => context.pop(), child: const Text("Update")),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account", style: TextStyle(color: Colors.red)),
        content: const Text("Are you sure you want to permanently delete your account? This action cannot be undone."),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => context.pop(),
            child: const Text("Delete Permanently"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Security")),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildActionTile(
            Icons.lock_outline_rounded,
            "Change Password",
            "Update your account password",
            onTap: _showPasswordDialog,
          ),
          _buildSwitchTile(
            Icons.fingerprint_rounded,
            "Biometric Authentication",
            "Use fingerprint or face ID",
            _biometricEnabled,
            (v) => setState(() => _biometricEnabled = v),
          ),
          _buildActionTile(Icons.devices_rounded, "Logged Devices", "Manage active sessions"),
          _buildActionTile(
            Icons.delete_forever_rounded,
            "Delete Account",
            "Permanently remove your data",
            color: Colors.red,
            onTap: _showDeleteAccountDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String subtitle, {Color? color, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppTheme.primaryColor),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}

class ReferFriendPage extends StatelessWidget {
  const ReferFriendPage({super.key});

  final String referralCode = "BPRO-1234-EYA";

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: referralCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Referral code copied to clipboard!"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.secondaryColor,
      ),
    );
  }

  void _shareLink(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Generating sharing link..."),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Refer a Friend")),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.card_giftcard_rounded, size: 100, color: AppTheme.primaryColor),
            const SizedBox(height: 32),
            const Text(
              "Spread the Love!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "Invite your friends to Benefit Services Pro and you'll both get \$10 off your next booking.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 48),
            InkWell(
              onTap: () => _copyToClipboard(context),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(referralCode, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.5)),
                    const Icon(Icons.copy_rounded, color: AppTheme.primaryColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => _shareLink(context),
              child: const Text("Share Referral Link"),
            ),
          ],
        ),
      ),
    );
  }
}
