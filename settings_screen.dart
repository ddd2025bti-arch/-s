import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  final bool showBackButton;

  const SettingsScreen({
    super.key,
    this.showBackButton = false,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _authService = AuthService();
  bool _pushNotifications = true;
  bool _smsAlerts = true;
  bool _examReminders = true;
  String _selectedLanguage = 'English';

  Future<void> _handleSignOut() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Sign Out', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to sign out from the SMRISS Smart Portal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _authService.signOut();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: widget.showBackButton,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings & Preferences', style: TextStyle(fontFamily: 'Outfit', fontSize: 17, fontWeight: FontWeight.bold)),
            Text('SMRISS GGSSS Mall Road Bathinda', style: TextStyle(fontSize: 11, color: AppColors.outline)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Account Profile Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.primaryContainer,
                  backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                  child: user?.photoURL == null
                      ? const Icon(Icons.person, color: Colors.white, size: 28)
                      : null,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? 'Amanpreet Kaur',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user?.email ?? 'amanpreet.kaur@bathinda.school',
                        style: const TextStyle(fontSize: 12, color: AppColors.outline),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.successBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Google Account Verified',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.success),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Notification Preferences',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.outline, letterSpacing: 0.5),
          ),
          const SizedBox(height: 8),

          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Push Notifications', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  subtitle: const Text('Circulars, timetable changes & event reminders', style: TextStyle(fontSize: 11)),
                  activeColor: AppColors.primaryContainer,
                  value: _pushNotifications,
                  onChanged: (v) => setState(() => _pushNotifications = v),
                ),
                const Divider(height: 1, color: AppColors.outlineVariant),
                SwitchListTile(
                  title: const Text('SMS / WhatsApp Alerts', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  subtitle: const Text('Emergency district notices and holiday alerts', style: TextStyle(fontSize: 11)),
                  activeColor: AppColors.primaryContainer,
                  value: _smsAlerts,
                  onChanged: (v) => setState(() => _smsAlerts = v),
                ),
                const Divider(height: 1, color: AppColors.outlineVariant),
                SwitchListTile(
                  title: const Text('Pre-Board & Exam Reminders', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  subtitle: const Text('Daily revision alerts & syllabus milestones', style: TextStyle(fontSize: 11)),
                  activeColor: AppColors.primaryContainer,
                  value: _examReminders,
                  onChanged: (v) => setState(() => _examReminders = v),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'General & Regional',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.outline, letterSpacing: 0.5),
          ),
          const SizedBox(height: 8),

          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language, color: AppColors.primary),
                  title: const Text('App Language', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  subtitle: Text(_selectedLanguage, style: const TextStyle(fontSize: 11)),
                  trailing: const Icon(Icons.chevron_right, size: 20),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Select Language', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            ListTile(
                              title: const Text('English (Default)'),
                              trailing: _selectedLanguage == 'English' ? const Icon(Icons.check, color: AppColors.primary) : null,
                              onTap: () {
                                setState(() => _selectedLanguage = 'English');
                                Navigator.pop(ctx);
                              },
                            ),
                            ListTile(
                              title: const Text('ਪੰਜਾਬੀ (Punjabi)'),
                              trailing: _selectedLanguage == 'ਪੰਜਾਬੀ' ? const Icon(Icons.check, color: AppColors.primary) : null,
                              onTap: () {
                                setState(() => _selectedLanguage = 'ਪੰਜਾਬੀ');
                                Navigator.pop(ctx);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Divider(height: 1, color: AppColors.outlineVariant),
                ListTile(
                  leading: const Icon(Icons.lock_outline, color: AppColors.primary),
                  title: const Text('Privacy & School Data Policy', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  trailing: const Icon(Icons.chevron_right, size: 20),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Punjab Education Dept Student Data Protection Standards applied.')),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Sign Out Button
          ElevatedButton.icon(
            onPressed: _handleSignOut,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.logout, size: 18),
            label: const Text('Sign Out from Portal', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),

          const SizedBox(height: 16),

          const Center(
            child: Text(
              'SMRISS Smart Portal v1.0.0 • Affiliated to PSEB',
              style: TextStyle(fontSize: 11, color: AppColors.outline),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
