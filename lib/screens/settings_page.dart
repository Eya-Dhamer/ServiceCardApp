import 'package:app_7/providers/theme_provider.dart';
import 'package:app_7/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _notifications = true;
  bool _darkMode = false;
  bool _biometric = true;
  String _selectedLanguage = "English (US)";

  void _showLanguageDialog() {
    final languages = ["English (US)", "Français (France)", "Español (España)", "Deutsch (Deutschland)"];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Language"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((lang) => RadioListTile<String>(
            title: Text(lang),
            value: lang,
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() => _selectedLanguage = value!);
              context.pop();
            },
            activeColor: AppTheme.primaryColor,
          )).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? null : Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("Account Settings"),
            _buildSettingsCard([
              _buildSwitchTile("Push Notifications", _notifications, (v) => setState(() => _notifications = v)),
              _buildSwitchTile("Biometric Login", _biometric, (v) => setState(() => _biometric = v)),
            ], isDarkMode),
            
            const SizedBox(height: 32),
            _buildSectionHeader("Appearance"),
            _buildSettingsCard([
              _buildSwitchTile("Dark Mode", isDarkMode, (v) => ref.read(themeProvider.notifier).toggleTheme(v)),
              _buildSettingsTile("Language", _selectedLanguage, onTap: _showLanguageDialog, isDarkMode: isDarkMode),
            ], isDarkMode),

            const SizedBox(height: 32),
            _buildSectionHeader("Privacy & Support"),
            _buildSettingsCard([
              _buildSettingsTile("Privacy Policy", "", onTap: () => context.push('/settings/privacy'), isDarkMode: isDarkMode),
              _buildSettingsTile("Terms of Service", "", onTap: () => context.push('/settings/terms'), isDarkMode: isDarkMode),
              _buildSettingsTile("About App", "v1.0.4", onTap: () => context.push('/settings/about'), isDarkMode: isDarkMode),
            ], isDarkMode),

            const SizedBox(height: 48),
            Center(
              child: Text(
                "Benefit Services Pro\nMade with ❤️ by Eya",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade400, fontSize: 12, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    ).animate().fadeIn().slideX(begin: -0.1, end: 0);
  }

  Widget _buildSettingsCard(List<Widget> children, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildSettingsTile(String title, String subtitle, {VoidCallback? onTap, bool isDarkMode = false}) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle.isNotEmpty ? Text(subtitle, style: TextStyle(color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade500, fontSize: 13)) : null,
      trailing: Icon(Icons.chevron_right_rounded, color: isDarkMode ? Colors.white30 : Colors.grey),
      onTap: onTap,
    );
  }
}
