import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mind_space/services/secure_storage_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  String userName = "Loading...";
  String userEmail = "Loading...";
  Box? userBox;
  final _secureStorage = SecureStorageService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    userBox = await Hive.openBox('user');
    List<String> userDetails = userBox?.get('userDetail', defaultValue: ["John Doe", "john.doe@example.com"]);
    setState(() {
      userName = userDetails[0];
      userEmail = userDetails[1];
    });
  }

  void _launchInstagram() async {
    final Uri instagramUrl = Uri.parse('https://www.instagram.com/sudhanshu.zen');
    if (!await launchUrl(instagramUrl, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open Instagram')),
      );
    }
  }

  void _logout() async {
    // Clear the stored token
    
    
    // Clear any user data if needed
    // await userBox?.clear();
    
    // Navigate to login page
    Navigator.of(context).pushNamedAndRemoveUntil('/loginpage', (route) => false);
    await _secureStorage.deleteToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage your app preferences',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 30),

                // Profile Section
                _buildSectionHeader('Profile'),
                const SizedBox(height: 16),
                _buildProfileCard(),
                const SizedBox(height: 30),

                // App Settings Section
                _buildSectionHeader('App Settings'),
                const SizedBox(height: 16),
                // Notifications
                _buildSettingsCard(
                  icon: Icons.notifications_rounded,
                  iconColor: Colors.blue,
                  title: 'Notifications',
                  subtitle: 'Get notified about new features',
                  trailing: Switch(
                    value: _notifications,
                    onChanged: (value) {
                      setState(() {
                        _notifications = value;
                      });
                    },
                    activeColor: Colors.orangeAccent,
                    activeTrackColor: Colors.orangeAccent.withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 14),

                // Help & Support with Instagram link
                _buildSettingsCard(
                  icon: Icons.support_agent_rounded,
                  iconColor: Colors.teal,
                  title: 'Help & Support',
                  subtitle: 'Connect with us on Instagram',
                  trailing: IconButton(
                    icon: Icon(
                      Icons.open_in_new,
                      color: Colors.orangeAccent,
                      size: 20,
                    ),
                    onPressed: _launchInstagram,
                  ),
                  onTap: _launchInstagram,
                ),
                const SizedBox(height: 30),

                // About Section
                _buildSectionHeader('About'),
                const SizedBox(height: 16),
                _buildSettingsCard(
                  icon: Icons.info_outline_rounded,
                  iconColor: Colors.amber,
                  title: 'About Mind Space',
                  subtitle: 'Version 1.0.0',
                  trailing: SizedBox.shrink(), // Remove arrow by providing empty widget
                  onTap: () {},
                ),
                const SizedBox(height: 30),

                // Log Out Button
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _logout,
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.orangeAccent,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.orangeAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                color: Colors.orangeAccent,
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildSettingsCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing ??
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey.shade400,
                      size: 16,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}